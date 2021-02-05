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

  desc "Update prices given the current buy/sell orders"
  task update_prices: :environment do
    t = Simulation.current_time
    Company.find_each { |c| c.update_price(c.calculate_price(t)) }
    Simulation.advance
  end
end
