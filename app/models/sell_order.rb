class SellOrder < ApplicationRecord
  belongs_to :player
  belongs_to :company
end
