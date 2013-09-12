class VisitedMigration < ActiveRecord::Migration
  def change
    create_table :visiteds, :primary_key => :user_id do |t|
		t.string :status, :default => "pending"
		t.text :message
 
      	t.timestamps
    end

    add_index :visiteds, :status
  end
end
