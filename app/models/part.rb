class Part < ApplicationRecord
  validates :part_number, presence: true

  belongs_to :supplier

  has_many :assemblies_parts
end
