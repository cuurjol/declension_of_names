class Person < ApplicationRecord
  has_one :declension_name, dependent: :destroy

  validates :first_name, :full_name, presence: true
end
