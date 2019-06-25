require 'test_helper'

class DatascrapperControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get datascrapper_index_url
    assert_response :success
  end

end
