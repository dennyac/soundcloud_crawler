$LOAD_PATH << Dir.pwd
require 'environment'
mapping = Hash.new(0)
 Track.where("genre is not NULL and genre !=''").select("id,genre").each do |u|
	u.genre.split(/\W+/).each do |w|
		if Corpu.where(word: w.downcase, attempt: 1).exists?
			mapping[[u.id,w.downcase]] += 1
		end
	end
end
mapping.each do |k,v|	
	Vector.create(track_id: k[0], word: k[1], count: v, attempt: 1)
end
