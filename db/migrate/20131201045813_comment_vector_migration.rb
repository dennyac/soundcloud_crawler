class CommentVectorMigration < ActiveRecord::Migration
  def change
    create_table :commentvectors do |t|
    	t.integer :attempt
    	t.integer :user_id
		t.string :word
		t.float :tf_idf
		t.string :prior_tfidf
		t.string :status
		t.text :message
      t.timestamps
    end

    add_index :commentvectors, :attempt
    add_index :commentvectors, :user_id
    add_index :commentvectors, :word
    add_index :commentvectors, :status

  end
end
