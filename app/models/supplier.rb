class Supplier < ApplicationRecord
  validates :name,  presence: true

  has_one :account
end
