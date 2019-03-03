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

  should "toggle_complete" do
    put toggle_complete_path(@list)
    @list.reload
    assert_redirected_to lists_url
    assert_equal "List was marked as #{@list.status}.", flash[:notice]
  end

  should "destroy list" do
    assert_difference("List.count", -1) do
      delete list_url(@list)
    end

    assert_redirected_to lists_url
    assert_equal "List was successfully deleted.", flash[:notice]
  end
end
