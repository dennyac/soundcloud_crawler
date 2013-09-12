class TrackModifyMigration < ActiveRecord::Migration
  def up
  	change_column :tracks, :title, :text
  	change_column :tracks, :description, :text
  end

  def down
  	change_column :tracks, :title, :string
  	change_column :tracks, :description, :string
  end
end
