require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:complete)
  end

  should "get index" do
    get tasks_url
    assert_response :success
  end

  should "get new" do
    get new_task_url
    assert_response :success
  end

  should "show task" do
    get task_url(@task)
    assert_response :success
  end

  should "get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  should "create task" do
    assert_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: @task.title,
          description: @task.description, 
          status: "pending"
        }
      }
    end

    assert_redirected_to lists_url
    assert_equal "Task was successfully created.", flash[:notice]
  end

  should "update task" do
    patch task_url(@task), params: { 
      task: { 
        title: @task.title,
        description: @task.description
      }
    }
    assert_redirected_to lists_url 
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  should "toggle_completion" do
    put toggle_completion_path(@task)
    @task.reload
    assert_redirected_to lists_url
    assert_equal "Task was marked as #{@task.status}.", flash[:notice]
  end

  should "destroy task" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end

    assert_redirected_to lists_url
    assert_equal "Task was successfully deleted.", flash[:notice]
  end
end
