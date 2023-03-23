class Book < ApplicationRecord
  validates :published_at, presence: true
  validates :isbn, presence: true
  validates :title, presence: true

  belongs_to :author

  has_many :assemblies_books
  has_many :assemblies, through: :assemblies_books

  validate :validate_isbn

  def validate_isbn
    unless ISBN.valid?(self.isbn)
      errors.add(:isbn, "is invalid")
    end
  end
end
