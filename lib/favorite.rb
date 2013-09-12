class Favorite < ActiveRecord::Base 
	belongs_to :user
  	belongs_to :track
  	has_many :vectors, :primary_key => "track_id", :foreign_key => "track_id", :class_name => "Vector"
  	validates :user_id, presence: true
  	validates :track_id, presence: true
end