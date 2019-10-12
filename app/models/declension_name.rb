class DeclensionName < ApplicationRecord
  belongs_to :person

  validates :genitive, :dative, :accusative, :instrumental, :prepositional, presence: true
end
