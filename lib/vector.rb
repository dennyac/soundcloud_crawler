class Vector < ActiveRecord::Base
	belongs_to :corpu, :primary_key => "word", :foreign_key  => "word", :class_name => "Corpu"
	has_many :favorites, :primary_key => "track_id", :foreign_key => "track_id", :class_name => "Favorite"
	has_many :comments, :primary_key => "track_id", :foreign_key => "track_id", :class_name => "Comment"
	belongs_to :track 
end


