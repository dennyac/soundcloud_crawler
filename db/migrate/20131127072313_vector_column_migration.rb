class VectorColumnMigration < ActiveRecord::Migration
  def change
    add_column :vectors, :idf, :float
    add_column :vectors, :tf_idf, :float
  end
end
