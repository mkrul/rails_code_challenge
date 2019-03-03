class RemoveListsIdAndTasksIdFromSubtasks < ActiveRecord::Migration[5.1]
  def change
    remove_reference :subtasks, :tasks, index: true, foreign_key: true
    remove_reference :subtasks, :lists, index: true, foreign_key: true
  end
end
