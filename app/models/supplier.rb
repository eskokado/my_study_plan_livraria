class Supplier < ApplicationRecord
  validates :name,  presence: true

  has_many :parts

  has_one :account
end
