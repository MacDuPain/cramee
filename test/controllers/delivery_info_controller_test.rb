require "test_helper"

class DeliveryInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get delivery_info_new_url
    assert_response :success
  end

  test "should get create" do
    get delivery_info_create_url
    assert_response :success
  end
end
