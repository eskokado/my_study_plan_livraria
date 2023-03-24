# frozen_string_literal: true

# Classe que representa a associação entre montagens e livros no sistema
class AssembliesBook < ApplicationRecord
  # Associações
  belongs_to :assembly
  belongs_to :book
end
