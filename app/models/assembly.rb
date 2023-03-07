class Assembly < ApplicationRecord
  validates :name, presence: true

  has_many :assemblies_parts
end
