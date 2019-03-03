class List < ApplicationRecord
  has_many :tasks
  validates :status, inclusion: { in: %w(complete pending) }
  validates :title, uniqueness: true

  STATUS_COMPLETE = "complete".freeze
  STATUS_PENDING = "pending".freeze
  DEFAULT_TITLE = "My List".freeze

  def new_status
    status == STATUS_COMPLETE ? STATUS_PENDING : STATUS_COMPLETE
  end

  def new_completed_at_time
    completed_at == nil ? Time.now : nil
  end

  def self.get_list_params(params)
    list_id = params[:list_id].present? ? params[:list_id] : self.find_by_title(params[:task][:list_name]).id
  end

  def get_incomplete_count
    self.tasks.count + Task.joins(:subtasks).count
  end

end

