class PlayerAsset < ApplicationRecord
  belongs_to :player
  belongs_to :company
end
