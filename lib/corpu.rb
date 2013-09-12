class Corpu < ActiveRecord::Base
	has_many :vectors, :primary_key => "word", :foreign_key => "word", :class_name => "Vector"
end


