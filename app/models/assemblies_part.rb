# Classe que representa a associação entre montagens e peças no sistema
class AssembliesPart < ApplicationRecord
  # Associações
  belongs_to :assembly
  belongs_to :part
end
