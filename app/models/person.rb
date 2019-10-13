class Person < ApplicationRecord
  has_one :declension_name, dependent: :destroy

  validates :first_name, :full_name, presence: true

  validates :first_name, :last_name, :middle_name, format: { with: /\A\p{Cyrillic}+\z/,
                                                             message: 'только русские буквы' }
end
