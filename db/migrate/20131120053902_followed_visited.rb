class FollowedVisited < ActiveRecord::Migration
  def change
    add_column :visiteds, :followed_processed, :integer, :default=>0
  end
end
