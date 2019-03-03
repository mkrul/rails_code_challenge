require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @list = lists(:default)
  end

  should "get index" do
    get lists_url
    assert_response :success
  end

  should "get new" do
    get new_list_url
    assert_response :success
  end

  should "get new_list_task" do
    get new_list_task_path(@list)
    assert_response :success
  end

  should "create list" do
    assert_difference("List.count") do
      post lists_url, params: { list: { title: @list.title } }
    end

    assert_redirected_to lists_url
  end

  test "should show list" do
    get list_url(@list)
    assert_response :success
  end

  should "get edit" do
    get edit_list_url(@list)
    assert_response :success
  end

  should "update list" do
    patch list_url(@list), params: { list: { title: @list.title } }
    assert_redirected_to list_url(@list)
  end

  context "toggle_complete" do
    setup do
      @pending_list = lists(:pending)
      @complete_list = lists(:complete)
    end

    should "mark a 'pending' list and all of its tasks as 'complete'" do
      put toggle_complete_path(@pending_list)
      @pending_list.reload
      assert @pending_list.completed_at.present?
      assert_equal @pending_list.completed_at, @pending_list.tasks[0].completed_at
      assert_redirected_to lists_url
      assert_equal "List was marked as complete.", flash[:notice]
    end

    should "mark a 'complete' list and all of its tasks as 'pending'" do
      put toggle_complete_path(@complete_list)
      @complete_list.reload
      refute @complete_list.completed_at.nil?
      assert_equal @complete_list.completed_at, @complete_list.tasks[0].completed_at
      assert_redirected_to lists_url
      assert_equal "List was marked as pending.", flash[:notice]
    end
  end

  should "destroy list" do
    assert_difference("List.count", -1) do
      delete list_url(@list)
    end

    assert_redirected_to lists_url
    assert_equal "List was successfully deleted.", flash[:notice]
  end
end
