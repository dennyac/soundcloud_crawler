class User < ActiveRecord::Base
	has_many :tracks, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  	has_many :followed_users, through: :relationships, source: :followed
  	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  	has_many :followers, through: :reverse_relationships
  	has_many :vectors, through: :tracks #vectors of tracks published by user
  	has_many :uservectors, dependent: :destroy #vector that represents user. Built upon tracks published/or through wvrn
  	has_many :visiteds, foreign_key: "user_id"
  	has_many :followed_vectors, through: :followed_users, source: :uservectors #returns published vectors of followed users
  	has_many :followed_visited, through: :followed_users, source: :visiteds #returns all the followed users who have been visited
  	has_many :favoritevectors, through: :favorites, source: :vectors
  	has_many :commentvectors, through: :comments, source: :vectors

	def self.set(x)
		User.new do |u|
			u.id = x.id
			u.username = x.username
		  	u.country = x.country
		  	u.full_name = x.full_name
		  	u.city = x.city
		  	u.description = x.description
		  	u.track_count = x.track_count
		  	u.playlist_count = x.playlist_count
		  	u.followers_count = x.followers_count
		  	u.followings_count = x.followings_count
		  	u.public_favorites_count = x.public_favorites_count
		end
	end
end