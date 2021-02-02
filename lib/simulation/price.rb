MIN_PRICE = 0.01

def update_price(company:, sim_time:)
  buys = company.buy_orders.where(sim_time: sim_time).sum(:price)
  sells = company.sell_orders.where(sim_time: sim_time).sum(:quantity)
  current_price = company.stock_prices.order(:sim_time).last.price
  volatility = 0.1
  amount = rand - 0.5
  new_price = [MIN_PRICE, current_price + volatility * amount].max

  puts "updating #{company.name}"
  puts "buys: #{buys}, sells: #{sells}"
  puts "#{current_price} => #{new_price}"
  company.stock_prices.create(price: new_price, sim_time: sim_time)
end
