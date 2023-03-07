class Part < ApplicationRecord
  validates :part_number, presence: true
end
