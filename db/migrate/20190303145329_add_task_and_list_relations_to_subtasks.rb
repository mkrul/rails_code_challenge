class AddTaskAndListRelationsToSubtasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :subtasks, :task, index: true, foreign_key: true
    add_reference :subtasks, :list, index: true, foreign_key: true
  end
end
