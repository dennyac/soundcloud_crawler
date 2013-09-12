class CommentMigration < ActiveRecord::Migration
  def change
    create_table :comments do |t|
		t.date :comment_created_at
		t.text :body
		t.integer :user_id
		t.integer :track_id
 
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :track_id

  end
end
