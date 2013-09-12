$LOAD_PATH << Dir.pwd
require 'environment'
Visited.where("status in ('followed_processed','processed','tracks_processed')").each do |v|
	u=User.find(v.id)
	u.vectors.group('word').sum('tf_idf').each do |w,t|
		#cnt=u.tracks.count
		#Check the logic
		tfidf=t.fdiv(u.vectors.group('track_id').count.count)
		Uservector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: 1, status: "tracks_processed")
	end
end


