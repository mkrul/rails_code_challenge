require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @pending_task = tasks(:default)
    @complete_task = tasks(:complete)
  end

  context "#new_status" do
    should "return 'complete' if status is 'pending'" do
      new_status = @pending_task.new_status
      assert_equal "complete", new_status
    end

    should "return 'pending' if status is 'complete'" do
      new_status = @complete_task.new_status
      assert_equal "pending", new_status
    end
  end

  context "#new_completed_at_time" do
    should "return 'nil' if completed_at has a timestamp" do
      time = @complete_task.new_completed_at_time
      assert_nil time
    end

    should "return a timestamp if completed_at is 'nil'" do
      time = @pending_task.new_completed_at_time
      assert time.instance_of?(Time)
    end
  end
end
