class Fighter < ApplicationRecord
  belongs_to :battle
  belongs_to :character

end