class TrackMigration < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
		t.date :track_created_at
		t.integer :user_id
		t.string :title
		t.string :sharing
		t.text :description
		t.integer :duration
		t.string :genre
		t.integer :shared_to_count
		t.text :tag_list
		t.integer :label_id
		t.string :label_name
		t.integer :release
		t.integer :release_day
		t.integer :release_month
		t.integer :release_year
		t.string :license
		t.string :track_type
		t.integer :bpm
		t.string :key_signature
		t.integer :comment_count
		t.integer :download_count
		t.integer :playback_count
		t.integer :favoritings_count
 
      	t.timestamps
    end

    add_index :tracks, :user_id
    add_index :tracks, :genre

  end
end
