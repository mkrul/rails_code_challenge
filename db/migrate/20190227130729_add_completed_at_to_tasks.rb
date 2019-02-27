class AddCompletedAtToTasks < ActiveRecord::Migration[5.1]
  def up
    add_column :tasks, :completed_at, :datetime
  end

  def down
    remove_column :tasks, :completed_at
  end
end
