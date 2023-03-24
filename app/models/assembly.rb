# Classe que representa uma montagem no sistema
class Assembly < ApplicationRecord
  # Validações
  validates :name, presence: true

  # Associações
  has_many :assemblies_parts
  has_many :parts, through: :assemblies_parts
  has_many :assemblies_books
  has_many :books, through: :assemblies_books

  # Escopo que filtra montagens que contêm uma parte com um nome específico
  #
  # @param part_name [String] O nome da parte para filtrar montagens
  # @return [ActiveRecord::Relation] Um conjunto de montagens que contêm a parte especificada
  scope :with_part_name, -> (part_name) { joins(:parts).where(parts: { name: part_name }) }
end
