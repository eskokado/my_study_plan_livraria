class Part < ApplicationRecord
  validates :part_number, presence: true

  has_many :assemblies_parts
end
