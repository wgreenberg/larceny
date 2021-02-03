Rails.application.routes.draw do
  get 'stock_prices/index'
  resources :companies do
    resources :stock_prices
  end
end
