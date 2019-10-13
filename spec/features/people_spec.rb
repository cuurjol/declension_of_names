require 'rails_helper'

RSpec.feature 'People', type: :feature do
  let!(:declension_name) { FactoryBot.create(:declension_name) }
  let(:person) { declension_name.person }

  scenario 'create a new person' do
    visit(root_path)
    click_link('Новый человек')
    fill_in('Имя', with: 'Вера')
    fill_in('Фамилия', with: 'Самсонова')
    fill_in('Отчество', with: 'Григорьевна')
    select('Женский', from: 'Пол')
    click_on('Сохранить')

    expect(page).to have_content('Человек был успешно создан.')
    expect(find_field('first_name').value).to eq('Вера')
    expect(find_field('last_name').value).to eq('Самсонова')
    expect(find_field('middle_name').value).to eq('Григорьевна')
    expect(find_field('sex').value).to eq('Женский')
    expect(find_field('full_name').value).to eq('Самсонова Вера Григорьевна')
  end

  scenario 'delete a person' do
    visit(root_path)

    expect(page).to have_content(person.first_name)
    expect(page).to have_content(person.last_name)
    expect(page).to have_content(person.middle_name)

    click_on('Удалить')

    expect(page).to have_content('Человек был успешно удалён.')
    expect(page).to have_content('Людей не найдено')
    expect(page).not_to have_content(person.first_name)
    expect(page).not_to have_content(person.last_name)
    expect(page).not_to have_content(person.middle_name)
  end
end
