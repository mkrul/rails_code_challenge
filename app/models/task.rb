class Task < ApplicationRecord
  belongs_to :list, optional: true
  has_many :subtasks
  validates :status, inclusion: { in: %w(complete pending) }

  STATUS_COMPLETE = "complete".freeze
  STATUS_PENDING = "pending".freeze

  def new_status
    status == STATUS_COMPLETE ? STATUS_PENDING : STATUS_COMPLETE
  end

  def new_completed_at_time
    completed_at == nil ? Time.now : nil
  end

  def self.format_params(title, description, list_id)
    data = {
      title: title,
      description: description,
      list_id: list_id
    }
    return data
  end

end

