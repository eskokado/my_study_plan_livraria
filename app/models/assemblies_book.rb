# frozen_string_literal: true
class AssembliesBook < ApplicationRecord
  belongs_to :assembly
  belongs_to :book
end
