10.times do
  names_array = Faker::Name.name_with_middle.split(' ')
  gender = Petrovich(lastname: names_array[0], firstname: names_array[1], middlename: names_array[2]).gender
  sex = gender == :male ? 'Мужской' : 'Женский'

  declension_name_params = {}

  Petrovich::CASES.reject { |i| i == :nominative }.each do |name_case|
    petrovich = Petrovich(lastname: names_array[0], firstname: names_array[1], middlename: names_array[2],
                          gender: gender).to(name_case)

    declension_name_params.store(name_case, last_name: petrovich.lastname, first_name: petrovich.firstname,
                                            middle_name: petrovich.middlename, full_name: petrovich.to_s)
  end

  person = Person.create(last_name: names_array[0], first_name: names_array[1], middle_name: names_array[2], sex: sex,
                         full_name: names_array.join(' '))

  declension_name_params.merge(person: person)

  DeclensionName.create(declension_name_params.merge(person: person))
end