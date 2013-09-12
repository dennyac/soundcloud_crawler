class Visited < ActiveRecord::Base
	self.primary_key = "user_id"
	belongs_to :user 
	#default_scope order: 'visiteds.created_at'
	# => default_scope -> { order('followed_processed DESC') }
end


