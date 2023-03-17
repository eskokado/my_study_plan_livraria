class Book < ApplicationRecord
  validates :published_at, presence: true
  validates :isbn, presence: true

  belongs_to :author

  has_many :assemblies_books
end
