class VectorStatusMigration < ActiveRecord::Migration
  def change
    add_column :vectors, :status, :string
  end
end
