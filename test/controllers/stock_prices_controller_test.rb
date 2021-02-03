require "test_helper"

class StockPricesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_prices_index_url
    assert_response :success
  end
end
