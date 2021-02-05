require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "price" do
    assert_equal companies(:a).price, stock_prices(:a_3).price
    assert_equal companies(:b).price, stock_prices(:b_2).price
  end

  test "past_prices" do
    assert_equal (companies(:b).past_prices 5), [stock_prices(:b_1)]
    assert_equal (companies(:a).past_prices 5), [
      stock_prices(:a_1),
      stock_prices(:a_2),
    ]

    assert_equal (companies(:a).past_prices 1), [stock_prices(:a_2)]
  end

  test "total_sells" do
    assert_equal companies(:a).total_sells(sim_time: 1), 3 + 5
    assert_equal companies(:b).total_sells(sim_time: 1), 5

    assert_equal companies(:a).total_sells(sim_time: 2), 1
    assert_equal companies(:b).total_sells(sim_time: 2), 2 + 5
  end

  test "total_buys" do
    assert_equal companies(:a).total_buys(sim_time: 1), 10
    assert_equal companies(:a).total_buys(sim_time: 2), 5
    assert_equal companies(:a).total_buys(sim_time: 3), 0

    assert_equal companies(:b).total_buys(sim_time: 1), 5
    assert_equal companies(:b).total_buys(sim_time: 2), 5
    assert_equal companies(:b).total_buys(sim_time: 3), 0
  end

  test "calculate_price" do
    start_price = companies(:a).price_at 1
    new_price = companies(:a).calculate_price 1
    assert new_price > start_price
  end

  test "update_price" do
    start_price = companies(:a).price
    companies(:a).update_price start_price + 1
    assert_equal companies(:a).price, start_price + 1
  end
end
