class Track < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :vectors, dependent: :destroy

	belongs_to :user
	#default_scope order: 'tracks.track_created_at DESC'


	def self.set(x)
		Track.new do |t|
		  	t.id = x.id
			t.track_created_at = x.created_at
			t.user_id = x.user_id
			t.title = x.title
			t.sharing = x.sharing
			t.description = x.description
			t.duration = x.duration
			t.genre = x.genre
			t.shared_to_count = x.shared_to_count
			t.tag_list = x.tag_list
			t.label_id = x.label_id
			t.label_name = x.label_name
			t.release = x.release
			t.release_day = x.release_day
			t.release_month = x.release_month
			t.release_year = x.release_year
			t.license = x.license
			t.track_type = x.track_type
			t.bpm = x.bpm
			t.key_signature = x.key_signature
			t.comment_count = x.comment_count
			t.download_count = x.download_count
			t.playback_count = x.playback_count
			t.favoritings_count = x.favoritings_count
		end
	end  
end