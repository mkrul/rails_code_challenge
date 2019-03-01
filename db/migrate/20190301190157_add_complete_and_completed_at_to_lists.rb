class AddCompleteAndCompletedAtToLists < ActiveRecord::Migration[5.1]
  def up
    add_column :lists, :status, :string, default: "pending", null: false 
    add_column :lists, :completed_at, :datetime
  end

  def down
    remove_column :lists, :status
    remove_column :lists, :completed_at
  end
end
