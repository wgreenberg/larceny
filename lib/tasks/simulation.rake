require 'simulation/price'

desc "Simulation tasks"
namespace :simulation do
  desc "Clear an existing simulation"
  task clear: :environment do
    Simulation.delete_all
    StockPrice.delete_all
    BuyOrder.delete_all
    SellOrder.delete_all
    PlayerAsset.delete_all
    PlayerCash.delete_all
    Company.delete_all
  end

  desc "Initialize a new simulation"
  task new: :clear do
    Simulation.create(generation: 1, sim_time: 1)
    require 'json'
    companies = JSON.load open "config/init_companies.json"
    companies.each do |company|
      c = Company.create(name: company["name"], symbol: company["symbol"])
      c.stock_prices.create(price: 0.0, sim_time: 1)
      c.save
    end
  end

  desc "Advances the simulation by one time step, updating prices/assets/cash balances"
  task step: :environment do
    t = Simulation.current_time

    # update company prices
    Company.find_each do |company|
      buys = company.total_buys(sim_time: t)
      sells = company.total_sells(sim_time: t)
      price = company.price_at t
      price += price_curve(buys: buys, sells: sells, volatility: 0.1, speed: 1)
      company.update_price([MIN_PRICE, price].max)
    end

    # evaluate buys/sells based on new price
    BuyOrder.where(sim_time: t).find_each do |order|
      quantity = order.player.stock_for(order.company)
      quantity += (order.price / (order.company.price_at t+1)).to_i
      order.player.update_stock(order.company, quantity)
    end
    SellOrder.where(sim_time: t).find_each do |order|
      cash = order.player.cash
      cash += order.quantity * (order.company.price_at t+1)
      order.player.update_cash(cash)
    end

    Simulation.advance
  end
end
