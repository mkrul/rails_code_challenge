require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:default)
    @pending_task = tasks(:pending)
  end

  should "get index" do
    get tasks_url
    assert_response :success
  end

  should "get new" do
    get new_task_url
    assert_response :success
  end

  should "create task" do
    assert_difference('Task.count') do
      post tasks_url, params: {
        task: {
          description: @task.description, 
          title: @task.title,
          status: 'pending'
        }
      }
    end

    assert_redirected_to task_url(Task.last)
  end

  should "show task" do
    get task_url(@task)
    assert_response :success
  end

  should "get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  should "update task" do
    patch task_url(@task), params: { 
      task: { 
        description: @task.description,
        title: @task.title
      }
    }
    assert_redirected_to task_url(@task)
  end

  should "toggle_completion" do
    put toggle_completion_path(@pending_task)
    assert_redirected_to tasks_url
    assert_equal "Task was marked as completed", flash[:notice]
  end

  should "destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_url
  end
end
