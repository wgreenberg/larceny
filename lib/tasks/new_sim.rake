desc "Clear out db and initialize a new simulation"
namespace :new_sim do
  task clear: :environment do
    StockPrice.delete_all
    BuyOrder.delete_all
    SellOrder.delete_all
    PlayerAsset.delete_all
    PlayerCash.delete_all
    Company.delete_all
  end

  task new: :clear do
    require 'json'
    companies = JSON.load open "config/init_companies.json"
    companies.each do |company|
      c = Company.create(name: company["name"], symbol: company["symbol"])
      c.stock_prices.create(price: 0.0, sim_time: 1)
      c.save
    end
  end
end
