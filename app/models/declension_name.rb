class DeclensionName < ApplicationRecord
  belongs_to :person
  serialize :genitive
  serialize :dative
  serialize :accusative
  serialize :instrumental
  serialize :prepositional

  validates :genitive, :dative, :accusative, :instrumental, :prepositional, presence: true
end
