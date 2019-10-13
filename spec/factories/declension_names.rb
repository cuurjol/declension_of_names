FactoryBot.define do
  factory :declension_name do
    association :person

    genitive do
      { last_name: 'Крюковой', first_name: 'Жанны', middle_name: 'Александровны',
        full_name: 'Крюковой Жанны Александровны' }
    end

    dative do
      { last_name: 'Крюковой', first_name: 'Жанне', middle_name: 'Александровне',
        full_name: 'Крюковой Жанне Александровне' }
    end

    accusative do
      { last_name: 'Крюкову', first_name: 'Жанну', middle_name: 'Александровну',
        full_name: 'Крюкову Жанну Александровну' }
    end

    instrumental do
      { last_name: 'Крюковой', first_name: 'Жанной', middle_name: 'Александровной',
        full_name: 'Крюковой Жанной Александровной' }
    end

    prepositional do
      { last_name: 'Крюковой', first_name: 'Жанне', middle_name: 'Александровне',
        full_name: 'Крюковой Жанне Александровне' }
    end
  end
end
