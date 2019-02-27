class AddStatusToTasks < ActiveRecord::Migration[5.1]
  def up
    add_column :tasks, :status, :string, default: 'pending', null: false
  end

  def down
    remove_column :tasks, :status
  end
end
