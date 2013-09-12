$LOAD_PATH << Dir.pwd
require 'environment'
Vector.where("status = 'pending'").find_in_batches do |b|
	b.each do |v|
		n_tracks=Vector.where(word: v.word).count
		idf=Math::log(556303.fdiv(n_tracks),2)
		v.idf=idf
		v.tf_idf=v.count*idf
		v.status="processed"
		v.save
	end
end