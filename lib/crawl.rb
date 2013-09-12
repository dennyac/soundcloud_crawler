class Crawl
	
	def initialize(client_id)
		@client=SoundClient.new(client_id)
		@log = Logger.new("#{Dir.pwd}/../log/crawl_#{client_id}.log",'daily')
		#@config.active_record.default_timezone = :mst
	end
	
	def initial_node(initial)
		Visited.create(user_id: initial)
		User.set(@client.get_user(initial)).save
	end
	
	def Traverse(count)
		while Visited.where(status: "pending_second_hop").exists? and count > 0 do
			begin
				v=Visited.where(status: "pending_second_hop").first
				v.update(status: "in_progress", message: @client.client_id)
				u = User.find(v.id)

				#Fetching user tracks
				@client.get_tracks(u.id).each do |t|
					unless Track.where(id: t.id).exists?
						Track.set(t).save
					end
				end

				#Fetching user comments
				@client.get_comments(u.id).each do |c|
					#unless Comment.where(id: c.id).exists?
						co=Comment.set(c)
						#If track is not present, fetch and store track and composer info
						unless Track.where(id: co.track_id).exists?
							tr=@client.get_track(co.track_id)
							unless User.where(id: tr.user_id).exists?
								User.set(@client.get_user(tr.user_id)).save
							end
							tr.save
						end
						co.save
					#end
				end
				

				#Fetching user favorited tracks

				@client.get_favorites(u.id).each do |t|
					#unless Favorite.where(user_id: u.id, track_id: t.id).exists?
						#If track is not present, fetch and store track and composer info
						unless Track.where(id: t.id).exists?
							tr=Track.set(t)
							unless User.where(id: tr.user_id).exists?
								User.set(@client.get_user(tr.user_id)).save
							end
							tr.save
						end
						Favorite.create(user_id: u.id, track_id: t.id)
					#end
				end



				#Fetching user's followers
				@client.get_followers(u.id).each do |f|
					unless User.exists?(f.id) 
						User.set(f).save
					end

					unless Relationship.where(follower_id: f.id,followed_id: u.id).exists? 
						Relationship.create(follower_id: f.id, followed_id: u.id)
					end

					unless Visited.exists?(f.id)
						Visited.create(user_id: f.id)
					end
				end


				@client.get_followed_users(u.id).each do |f|
					unless User.exists?(f.id)
						User.set(f).save
					end

					unless Relationship.where(follower_id: u.id,followed_id: f.id).exists? 
						Relationship.create(follower_id: u.id, followed_id: f.id)
					end

					unless Visited.exists?(f.id)
						Visited.create(user_id: f.id)
					end
				end


				v.update(status: 'followed_processed',message: "completed")
				count -= 1		
			rescue Exception => e
				if e.inspect != "#<ActiveRecord::StaleObjectError: Attempted to update a stale object: Visited>"
					v.update(status: "error",message: e.inspect)
					@log.warn("Encountered error - #{e.inspect}.")
				end	
				next
			end
		end
	end
	
end


