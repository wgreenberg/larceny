class Company < ApplicationRecord
  has_many :stock_prices
  has_many :buy_orders
  has_many :sell_orders
  has_many :player_assets

  def price
    stock_prices.order(:sim_time).last.price
  end

  def past_prices(n)
    prices = stock_prices.order(sim_time: :desc).limit n+1
    return prices[1..]
  end
end
