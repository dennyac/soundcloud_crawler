$LOAD_PATH << Dir.pwd
require 'environment'
Vector.all.find_each do |v|
	#Need to probably move the below statement above.
	t_tracks=Vector.distinct.count(:track_id) 
	n_tracks=Vector.where(word: v.word).count
	idf=Math::log(t_tracks.fdiv(n_tracks),2)
	v.idf=idf
	v.tf_idf=v.count*idf
	v.save
end