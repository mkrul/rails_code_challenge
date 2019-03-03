class Subtask < ApplicationRecord
  belongs_to :task, optional: true
end
