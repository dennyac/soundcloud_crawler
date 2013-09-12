$LOAD_PATH << Dir.pwd
require 'environment'
Visited.where("status = 'wvrn_pending1'").find_in_batches(batch_size: 200) do |b|
		b.each do |v|
			u=User.find(v.id)
			u.followed_vectors.group('word').sum('tf_idf').each do |w,t|
				tfidf=t.fdiv(u.followed_users.count)
					Uservector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: 1, status: "processed")
			end
		end
	end
