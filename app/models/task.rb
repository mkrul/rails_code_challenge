class Task < ApplicationRecord

  STATUS_COMPLETE = 'complete'.freeze
  STATUS_PENDING = 'pending'.freeze

  def new_status
    self.status == STATUS_COMPLETE ? STATUS_PENDING : STATUS_COMPLETE
  end

end
