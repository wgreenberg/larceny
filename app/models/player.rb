class Player < ApplicationRecord
  has_many :buy_orders
  has_many :sell_orders
  has_many :player_assets
  has_many :player_cashes

  def buy(company:, price:, sim_time:)
    order = buy_orders.find_or_create_by(sim_time: sim_time, company: company)
    order.price = price
    order.save
  end

  def sell(company:, quantity:, sim_time:)
    order = sell_orders.find_or_create_by(sim_time: sim_time, company: company)
    order.quantity = quantity
    order.save
  end

  def cash
    cash_at Simulation.current_time
  end

  def cash_at(t)
    player_cashes.where("sim_time <= ?", t)
      .order(:sim_time)
      .last
      .amount
  end

  def update_cash(amount)
    cash = player_cashes.find_or_create_by(sim_time: Simulation.next_time)
    cash.amount = amount
    cash.save
  end

  def stocks_for(company)
    asset = player_assets.where("sim_time <= ?", Simulation.current_time)
      .where(company: company)
      .order(:sim_time)
      .last
    return 0 unless asset
    asset.quantity
  end

  def update_stocks(company, quantity)
    asset = player_assets.find_or_create_by(company: company, sim_time: Simulation.next_time)
    asset.quantity = quantity
    asset.save
  end
end
