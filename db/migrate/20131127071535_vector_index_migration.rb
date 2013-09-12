class VectorIndexMigration < ActiveRecord::Migration
  def change
    add_index :vectors, :word
  end
end
