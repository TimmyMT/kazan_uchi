require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get repositories_new_url
    assert_response :success
  end

  test "should get show" do
    get repositories_show_url
    assert_response :success
  end

end
