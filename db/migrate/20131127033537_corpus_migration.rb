class CorpusMigration < ActiveRecord::Migration
  def change
    create_table :corpus do |t|
    	t.integer :attempt
		t.string :word
		t.integer :total_count
		t.integer :document_count
      t.timestamps
    end

    add_index :corpus, :word
    add_index :corpus, :attempt
    add_index :corpus, :document_count

  end
end
