class AddListIdToTasks < ActiveRecord::Migration[5.1]
  def up
    add_reference :tasks, :lists, index: true
  end

  def down
    remove_reference :tasks, :lists
  end
end
