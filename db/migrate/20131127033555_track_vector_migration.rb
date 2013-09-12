class TrackVectorMigration < ActiveRecord::Migration
  def change
    create_table :vectors do |t|
    	t.integer :attempt
    	t.integer :track_id
		t.string :word
		t.integer :count
      t.timestamps
    end

    add_index :vectors, :attempt
    add_index :vectors, :track_id

  end
end
