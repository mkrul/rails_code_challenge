require "test_helper"

class TaskTest < ActiveSupport::TestCase
  context "#new_status" do
    setup do
      @pending_task = tasks(:default)
      @completed_task = tasks(:complete)
    end

    should "return 'complete' if status is 'pending'" do
      new_status = @pending_task.new_status
      assert_equal "complete", new_status
    end

    should "return 'pending' if status is 'complete'" do
      new_status = @completed_task.new_status
      assert_equal "pending", new_status
    end
  end
end
