class Favoritevector < ActiveRecord::Base
	belongs_to :corpu, :primary_key => "word", :foreign_key  => "word", :class_name => "Corpu"
	belongs_to :user 
end


