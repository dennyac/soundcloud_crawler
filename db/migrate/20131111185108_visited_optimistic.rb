class VisitedOptimistic < ActiveRecord::Migration
  def change
    add_column :visiteds, :lock_version, :integer, :default=>0
  end
end
