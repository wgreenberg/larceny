class Player < ApplicationRecord
  has_many :buy_orders
  has_many :sell_orders
  has_many :player_assets
end
