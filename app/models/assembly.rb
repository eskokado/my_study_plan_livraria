class Assembly < ApplicationRecord
  validates :name, presence: true

  has_many :assemblies_parts
  has_many :assemblies_books
end
