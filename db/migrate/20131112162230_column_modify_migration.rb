class ColumnModifyMigration < ActiveRecord::Migration
  def up
  	change_column :tracks, :release, :string
  	change_column :users, :full_name, :text
  end

  def down
  	change_column :tracks, :release, :integer
  	change_column :users, :full_name, :string
  end
end
