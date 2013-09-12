$LOAD_PATH << Dir.pwd
require 'environment'
mapping = Hash.new(0)
 Track.where("genre is not NULL and genre !=''").select("genre").each do |u|
	u.genre.split(/\W+/).each do |w|
		if Stopwords.valid?(w.downcase) #and !Stopwords.is?(w.downcase)
			mapping[w.downcase] += 1
		end
	end
end
mapping.each do |k,v|
	Corpu.create(word: k, total_count: v, attempt: 1)
end
