class BuyOrder < ApplicationRecord
  belongs_to :player
  belongs_to :company
end
