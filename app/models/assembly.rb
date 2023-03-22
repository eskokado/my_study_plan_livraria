class Assembly < ApplicationRecord
  validates :name, presence: true

  has_many :assemblies_parts
  has_many :parts, through: :assemblies_parts
  has_many :assemblies_books

  scope :with_part_name, -> (part_name) { joins(:parts).where(parts: { name: part_name }) }
end
