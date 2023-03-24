# Classe que representa um fornecedor no sistema
class Supplier < ApplicationRecord
  # Validações
  validates :name,  presence: true
  validates :cnpj, presence: true

  # Associações
  has_many :parts
  has_one :account

  # Validação personalizada
  validate :validate_cnpj

  # Valida o campo cnpj
  #
  # @return [void]
  def validate_cnpj
    cnpj = CNPJ.new(self.cnpj)
    unless cnpj.valid?
      errors.add(:cnpj, "is invalid")
    end
  end

  # Busca um fornecedor com autores e livros associados
  #
  # @param supplier_id [Integer] O ID do fornecedor
  # @return [Supplier] O objeto Supplier com dados de autores e livros carregados
  def self.supplier_with_authors_and_books(supplier_id)
    joins(parts: { book: :author })
      .preload(parts: { book: :author })
      .find(supplier_id)
  end
end
