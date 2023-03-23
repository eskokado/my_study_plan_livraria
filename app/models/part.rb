class Part < ApplicationRecord
  validates :part_number, presence: true
  validates :name, presence: true
  validates :value, presence: true

  belongs_to :supplier
  belongs_to :book
  has_many :assemblies_parts
  has_many :assemblies, through: :assemblies_parts
end
