class VisitedPriority < ActiveRecord::Migration
  def change
    add_column :visiteds, :priority, :integer, :default=>0
    add_column :visiteds, :track_count, :integer
  end
end
