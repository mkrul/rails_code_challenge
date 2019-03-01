class DropListsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :lists
  end
end
