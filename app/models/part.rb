# Classe que representa uma peça no sistema
class Part < ApplicationRecord
  # Validações
  validates :part_number, presence: true
  validates :name, presence: true
  validates :value, presence: true

  # Associações
  belongs_to :supplier
  belongs_to :book
  has_many :assemblies_parts
  has_many :assemblies, through: :assemblies_parts
end
