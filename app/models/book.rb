# Classe que representa um livro no sistema
class Book < ApplicationRecord
  # Validações
  validates :published_at, presence: true
  validates :isbn, presence: true
  validates :title, presence: true

  # Associações
  belongs_to :author
  has_many :assemblies_books
  has_many :assemblies, through: :assemblies_books

  # Validação personalizada
  validate :validate_isbn

  # Valida o campo ISBN
  #
  # @return [void]
  def validate_isbn
    unless ISBN.valid?(self.isbn)
      errors.add(:isbn, "is invalid")
    end
  end
end
