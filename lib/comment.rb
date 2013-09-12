class Comment < ActiveRecord::Base
	#attr_accessible :body #, :user_id
  	belongs_to :user
  	belongs_to :track
  	has_many :vectors, :primary_key => "track_id", :foreign_key => "track_id", :class_name => "Vector"

  	#default_scope order: 'comments.comment_created_at DESC'
  
  	validates :user_id, presence: true
  	validates :track_id, presence: true
  	#validates :body, presence: true #, length: { maximum: 140 }
	def self.set(x)
		Comment.new do |c|
			c.id = x.id
			c.comment_created_at = x.created_at
			c.body = x.body
			c.user_id = x.user_id
			c.track_id = x.track_id
		end
	end 
end