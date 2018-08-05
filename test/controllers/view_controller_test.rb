require 'test_helper'

class ViewControllerTest < ActionDispatch::IntegrationTest
  test "should get keyword" do
    get view_keyword_url
    assert_response :success
  end

end
