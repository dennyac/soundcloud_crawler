class FavoriteVectorMigration < ActiveRecord::Migration
  def change
    create_table :favoritevectors do |t|
    	t.integer :attempt
    	t.integer :user_id
		t.string :word
		t.float :tf_idf
		t.string :prior_tfidf
		t.string :status
		t.text :message
      t.timestamps
    end

    add_index :favoritevectors, :attempt
    add_index :favoritevectors, :user_id
    add_index :favoritevectors, :word
    add_index :favoritevectors, :status

  end
end
