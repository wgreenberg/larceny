require 'simulation/price'

class Company < ApplicationRecord
  has_many :stock_prices
  has_many :buy_orders
  has_many :sell_orders
  has_many :player_assets

  def price
    stock_prices.order(:sim_time).last.price
  end

  def price_at(t)
    stock_prices.where(sim_time: t).first.price
  end

  def calculate_price(t)
    buys = total_buys(sim_time: t)
    sells = total_sells(sim_time: t)
    price_delta = price_curve(buys: buys, sells: sells, volatility: 0.1, speed: 1)
    return [MIN_PRICE, price + price_delta].max
  end

  def update_price(new_price)
    stock_prices.create(price: new_price, sim_time: Simulation.current_time + 1)
  end

  def past_prices(n)
    prices = stock_prices.order(sim_time: :desc).limit n+1
    return prices[1..].reverse
  end

  def total_buys(sim_time:)
    total_buy_price = buy_orders.where(sim_time: sim_time).sum(:price)
    price = stock_prices.where("sim_time <= ?", sim_time)
      .order(:sim_time)
      .last
      .price
    return total_buy_price/price
  end

  def total_sells(sim_time:)
    return sell_orders.where(sim_time: sim_time).sum(:quantity)
  end
end
