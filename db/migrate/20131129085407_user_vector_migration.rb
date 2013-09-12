class UserVectorMigration < ActiveRecord::Migration
  def change
    create_table :uservectors do |t|
    	t.integer :attempt
    	t.integer :user_id
		t.string :word
		t.float :tf_idf
		t.string :prior_tfidf
		t.string :status
		t.text :message
      t.timestamps
    end

    add_index :uservectors, :attempt
    add_index :uservectors, :user_id
    add_index :uservectors, :word
    add_index :uservectors, :status

  end
end
