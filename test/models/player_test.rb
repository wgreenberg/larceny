require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def get_buys(player:, company:, sim_time:)
    players(player).buy_orders
      .where(company: companies(company), sim_time: 1)
      .all.map { |buy| buy.price }
  end

  def get_sells(player:, company:, sim_time:)
    players(player).sell_orders
      .where(company: companies(company), sim_time: 1)
      .all.map { |buy| buy.quantity }
  end

  test "buy" do
    assert_equal get_buys(player: :p1, company: :a, sim_time: 1), [10]
    players(:p1).buy(company: companies(:a), price: 20, sim_time: 1)
    assert_equal get_buys(player: :p1, company: :a, sim_time: 1), [20]
  end

  test "sell" do
    assert_equal get_sells(player: :p1, company: :a, sim_time: 1), [3]
    players(:p1).sell(company: companies(:a), quantity: 10, sim_time: 1)
    assert_equal get_sells(player: :p1, company: :a, sim_time: 1), [10]
  end

  test "cash" do
    assert_equal players(:p1).cash, 100
    assert_equal players(:p2).cash, 200
  end

  test "update_cash" do
    players(:p1).update_cash 200
    assert_equal players(:p1).cash, 100
    Simulation.advance
    assert_equal players(:p1).cash, 200
  end

  test "get_assets" do
    assert_equal players(:p1).stocks_for(companies(:a)), 10
    assert_equal players(:p1).stocks_for(companies(:b)), 0
    assert_equal players(:p2).stocks_for(companies(:a)), 0
    assert_equal players(:p2).stocks_for(companies(:b)), 20
  end

  test "update_stocks" do
    players(:p1).update_stocks(companies(:a), 20)
    assert_equal players(:p1).stocks_for(companies(:a)), 10
    Simulation.advance
    assert_equal players(:p1).stocks_for(companies(:a)), 20
  end
end
