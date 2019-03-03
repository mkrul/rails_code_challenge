class CreateSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subtasks do |t|
      t.string :title
      t.text :description
      t.string "status", default: "pending", null: false
      t.datetime "completed_at"
      t.timestamps
      t.references :tasks, index: true, foreign_key: true
      t.references :lists, index: true, foreign_key: true
    end
  end

  def down
    drop_table :subtasks
  end
end
