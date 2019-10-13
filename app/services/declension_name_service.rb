class DeclensionNameService < ApplicationService
  def initialize(person)
    @person = person
    @last_name = person.last_name
    @first_name = person.first_name
    @middle_name = person.middle_name
    @gender = person.sex == 'Мужской' ? :male : :female
  end

  def call
    params = create_petrovich_hash.merge(person: @person)
    @person.declension_name.blank? ? DeclensionName.create(params) : @person.declension_name.update(params)
  end

  private

  def create_petrovich_hash
    hash = {}

    Petrovich::CASES.reject { |i| i == :nominative }.each do |name_case|
      petrovich = Petrovich(lastname: @last_name, firstname: @first_name, middlename: @middle_name, gender: @gender)
                  .to(name_case)

      hash.store(name_case, last_name: petrovich.lastname, first_name: petrovich.firstname,
                            middle_name: petrovich.middlename, full_name: petrovich.to_s)
    end

    hash
  end
end
