$LOAD_PATH << Dir.pwd
require 'environment'
3.times do 
	Visited.where("status in ('followed_processed','processed')").each do |v|
		u=User.find(v.id)
		u.followed_vectors.group('word').sum('tf_idf').each do |w,t|
			tfidf=t.fdiv(u.followed_users.count)
			if Uservector.where(user_id: u.id, word: w).exists?
				fu=Uservector.find_by user_id: u.id, word: w
				fu.prior_tfidf << ",#{tfidf}"
				fu.tf_idf=tfidf
				fu.attempt += 1
				fu.save
			else
				Uservector.create(user_id: u.id, word: w, tf_idf: tfidf, prior_tfidf: tfidf, attempt: 1, status: "processed")
			end
		end
	end
end
