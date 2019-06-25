require 'test_helper'

class FoodItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get food_items_index_url
    assert_response :success
  end

end
