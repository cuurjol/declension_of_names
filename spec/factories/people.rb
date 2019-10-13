FactoryBot.define do
  factory :person do
    first_name { 'Жанна' }
    last_name { 'Крюкова' }
    middle_name { 'Александровна' }
    sex { 'Женский' }
    full_name { [last_name, first_name, middle_name].join(' ') }
  end
end
