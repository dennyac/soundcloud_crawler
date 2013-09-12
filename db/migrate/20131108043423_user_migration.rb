class UserMigration < ActiveRecord::Migration
   def change
    create_table :users do |t|
	  t.string :username
	  t.string :country
	  t.string :full_name
	  t.string :city
	  t.text :description
	  t.integer :track_count
	  t.integer :playlist_count
	  t.integer :followers_count
	  t.integer :followings_count
	  t.integer :public_favorites_count
 
      t.timestamps
    end
  end
end
