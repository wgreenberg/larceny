class Company < ApplicationRecord
  has_many :stock_prices
  has_many :buy_orders
  has_many :sell_orders
  has_many :player_assets

  def price
    price_at Simulation.current_time
  end

  def price_at t
    stock_prices.where("sim_time <= ?", t)
      .order(:sim_time)
      .last
      .price
  end

  def update_price new_price
    next_price = stock_prices.find_or_create_by(sim_time: Simulation.next_time)
    next_price.price = new_price
    next_price.save
  end

  def past_prices n
    stock_prices.where("sim_time <= ?", Simulation.current_time)
      .order(sim_time: :desc)
      .limit(n)
      .reverse
  end

  def total_buys sim_time:
    total_buy_price = buy_orders.where(sim_time: sim_time).sum(:price)
    total_buy_price/(price_at sim_time)
  end

  def total_sells sim_time:
    sell_orders.where(sim_time: sim_time).sum(:quantity)
  end
end
