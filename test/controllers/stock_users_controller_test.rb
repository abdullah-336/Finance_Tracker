require "test_helper"

class StockUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_portfolio" do
    get stock_users_my_portfolio_url
    assert_response :success
  end
end
