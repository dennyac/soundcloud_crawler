
class Preprocess

	def self.build_corpus(attmpt)
		mapping = Hash.new(0)
		Track.where("genre is not NULL and genre !=''").select("genre").each do |u|
			u.genre.split(/\W+/).each do |w|
				if Stopwords.valid?(w.downcase) #and !Stopwords.is?(w.downcase)
					mapping[w.downcase] += 1
				end
			end
		end
		mapping.each do |k,v|
			Corpu.create(word: k, total_count: v, attempt: attmpt)
		end
	end

	def self.create_track_vector(attmpt)
		mapping = Hash.new(0)
		 Track.where("genre is not NULL and genre !=''").select("id,genre").each do |u|
			u.genre.split(/\W+/).each do |w|
				if Corpu.where(word: w.downcase, attempt: attmpt).exists?
					mapping[[u.id,w.downcase]] += 1
				end
			end
		end
		mapping.each do |k,v|	
			Vector.create(track_id: k[0], word: k[1], count: v, attempt: attmpt, type: "track")
		end
	end

	def self.calculate_tfidf
		t_tracks=Vector.distinct.count(:track_id) 
		Vector.all.find_each do |v|
			n_tracks=Vector.where(word: v.word).count
			idf=Math::log(t_tracks.fdiv(n_tracks),2)
			v.idf=idf
			v.tf_idf=v.count*idf
			v.save
		end
	end

	def self.batch_calculate_tfidf
		t_tracks=Vector.distinct.count(:track_id)
		Vector.where("status = 'pending'").find_in_batches do |b|
			b.each do |v|
				n_tracks=Vector.where(word: v.word).count
				idf=Math::log(t_tracks.fdiv(n_tracks),2)
				v.idf=idf
				v.tf_idf=v.count*idf
				v.status="processed"
				v.save
			end
		end
	end

	def self.create_comment_vector(status,attmpt)
		Visited.where("status in ('#{status}')").find_in_batches do |b|
			b.each do |v|
				u=User.find(v.id)
				u.commentvectors.group('word').sum('tf_idf').each do |w,t|
					tfidf=t.fdiv(u.commentvectors.group('vectors.track_id').count.count)
					Commentvector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: attmpt, status: "processed")
				end
			end
		end
	end

	def self.create_favorite_vector(status,attmpt)
		Visited.where("status in ('#{status}')").find_in_batches do |b|
			b.each do |v|
				u=User.find(v.id)
				u.favoritevectors.group('word').sum('tf_idf').each do |w,t|
					tfidf=t.fdiv(u.favoritevectors.group('vectors.track_id').count.count)
					Favoritevector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: attmpt, status: "processed")
				end
			end
		end
	end

	def self.create_user_vector(status,attmpt)
		Visited.where("status in ('#{status}')").each do |v|
			u=User.find(v.id)
			u.vectors.group('word').sum('tf_idf').each do |w,t|
				#cnt=u.tracks.count
				#Check the logic
				tfidf=t.fdiv(u.vectors.group('track_id').count.count)
				Uservector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: attmpt, status: "tracks_processed")
			end
		end
	end

	def self.create_user_vector_wvrn(status,rounds)
		rounds.times do 
			Visited.where("status = '#{status}'").find_in_batches(batch_size: 200) do |b|
				b.each do |v|
					u=User.find(v.id)
					u.followed_vectors.group('word').sum('tf_idf').each do |w,t|
						tfidf=t.fdiv(u.followed_users.count)
						if Uservector.where(user_id: u.id, word: w).exists?
							fu=Uservector.find_by user_id: u.id, word: w
							fu.prior_tfidf << ",#{tfidf}"
							fu.tf_idf=tfidf
							fu.attempt += 1
							fu.save
						else
							Uservector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: 1, status: "processed")
						end
					end
				end
			end
		end
	end

end

