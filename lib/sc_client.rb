class SoundClient
	
	@log = Logger.new("#{Dir.pwd}/../log/sc_client.log",'daily')

	def initialize(client_id)
		begin
			@log = Logger.new("#{Dir.pwd}/../log/sc_client_#{client_id}.log",'daily')
			@client = Soundcloud.new(:client_id => client_id)
		rescue Exception => e
			@log.warn("Unable to authenticate client #{client_id} => #{e.inspect}")
			raise Exception.new("Unable to authenticate #{client_id}")
		end
	end

	def client_id
		@client.client_id
	end

	def get_user(id)
		attempts=0
		begin
			uri="/users/#{id}/"
			sleep(rand(2))
			@client.get(uri)
		rescue Exception => e
			@log.info("No reponse when fetching new user for #{id}- #{e.inspect}")
			sleep(rand(2))
			attempts += 1
			if attempts > 20
				@log.warn("Skipping User #{id}")
				raise Exception.new("Unable to fetch User #{id}")
				#update queue to failed.
			end
			if e.inspect != "Interrupt"
				retry
			end
		end
	end

	def get_followers(id)
		uri = "/users/#{id}/followers"
		followers_list = SoundCloud::ArrayResponseWrapper.new()
		limit = 50
		begin
			begin
				sleep(rand(2))
				temp_list = @client.get(uri, {:offset => followers_list.length, :limit => limit})				
			rescue Exception => e
				@log.info("No reponse when fetching followers_list for #{id}- #{e.inspect}")
				if e.inspect != "Interrupt"
					retry
				end
			end
			followers_list += temp_list
		end while temp_list.length >= limit and followers_list.length < 1000
		return followers_list
	end

	def get_followed_users(id)
		uri = "/users/#{id}/followings"
		followings_list = SoundCloud::ArrayResponseWrapper.new()
		limit = 50
		begin
			begin
				sleep(rand(2))
				temp_list = @client.get(uri, {:offset => followings_list.length, :limit => 50})
			rescue Exception => e
				@log.info("No reponse when fetching followings_list for #{id} - #{e.inspect}")
				if e.inspect != "Interrupt"
					retry
				end
			end
			followings_list += temp_list
		end while temp_list.length >= limit and followings_list.length < 1000
		return followings_list
	end

	def get_tracks(id)
		uri = "/users/#{id}/tracks"
		track_list = SoundCloud::ArrayResponseWrapper.new()
		limit = 50
		begin
			begin
				sleep(rand(2))
				temp_list = @client.get(uri, {:offset => track_list.length, :limit => limit})				
			rescue Exception => e
				@log.info("No reponse when fetching track_list for #{id}- #{e.inspect}")
				if e.inspect != "Interrupt"
					retry
				end
			end
			track_list += temp_list
		end while temp_list.length >= limit and track_list.length < 1000
		return track_list
	end

	def get_track(id)
		attempts=0
		begin
			uri="/tracks/#{id}/"
			sleep(rand(2))
			@client.get(uri)
		rescue Exception => e
			@log.info("No reponse when fetching track #{id}- #{e.inspect}")
			sleep(rand(2))
			attempts += 1
			if attempts > 20
				@log.warn("Skipping Track #{id}")
				raise Exception.new("Unable to fetch Track #{id}")
				#update queue to failed.
			end
			if e.inspect != "Interrupt"
				retry
			end
		end
	end

	def get_comments(id)
		uri = "/users/#{id}/comments"
		comment_list = SoundCloud::ArrayResponseWrapper.new()
		limit = 50
		begin
			begin
				sleep(rand(2))
				temp_list = @client.get(uri, {:offset => comment_list.length, :limit => limit})				
			rescue Exception => e
				@log.info("No reponse when fetching comment_list for #{id}- #{e.inspect}")
				if e.inspect != "Interrupt"
					retry
				end
			end
			comment_list += temp_list
		end while temp_list.length >= limit and comment_list.length < 1000
		return comment_list
	end

	def get_favorites(id)
		uri = "/users/#{id}/favorites"
		favorite_tracks = SoundCloud::ArrayResponseWrapper.new()
		limit = 50
		begin
			begin
				sleep(rand(2))
				temp_list = @client.get(uri, {:offset => favorite_tracks.length, :limit => limit})				
			rescue Exception => e
				@log.info("No reponse when fetching favorite_tracks for #{id}- #{e.inspect}")
				if e.inspect != "Interrupt"
					retry
				end
			end
			favorite_tracks += temp_list
		end while temp_list.length >= limit and favorite_tracks.length < 1000
		return favorite_tracks
	end
end
