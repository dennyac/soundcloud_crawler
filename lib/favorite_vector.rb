$LOAD_PATH << Dir.pwd
require 'environment'
Visited.where("status in ('followed_processed','processed')").find_in_batches do |b|
	b.each do |v|
		u=User.find(v.id)
		u.favoritevectors.group('word').sum('tf_idf').each do |w,t|
			tfidf=t.fdiv(u.favoritevectors.group('vectors.track_id').count.count)
			Favoritevector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: 1, status: "processed")
		end
	end
end


