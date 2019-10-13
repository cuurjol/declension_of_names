require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  render_views

  describe '#index' do
    context 'when table of people will be showed' do
      before(:each) { FactoryBot.create(:declension_name) }
      before(:each) { get(:index) }

      it 'returns list of people' do
        expect(assigns(:people)).to_not be_nil
        expect(assigns(:people).count).to eq(1)
      end

      it 'renders index view' do
        expect(response.status).to eq(200)
        expect(response).to render_template(:index)
        expect(response.body).to match('Список людей')
        expect(response.body).to match('Жанна')
        expect(response.body).to match('Крюкова')
        expect(response.body).to match('Александровна')
      end
    end
  end

  describe '#new' do
    context 'when new person form will be created' do
      before(:each) { get(:new) }

      it 'assigns new person to @person' do
        expect(assigns(:person)).to_not be_nil
        expect(assigns(:person)).to be_a_new(Person)
          .with(first_name: nil, last_name: nil, middle_name: nil, sex: nil, full_name: nil)
      end

      it 'renders new view' do
        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
        expect(response.body).to match('Новый человек')
      end
    end
  end

  describe '#create' do
    context 'when new record will be created' do
      it 'successfully creates new record' do
        expect do
          post(:create, params: { person: { first_name: 'Вера', last_name: 'Самсонова', middle_name: 'Григорьевна',
                                            sex: 'Женский' } })
        end.to change { Person.count }.from(0).to(1)
      end

      it 'redirects to show view' do
        post(:create, params: { person: { first_name: 'Вера', last_name: 'Самсонова', middle_name: 'Григорьевна',
                                          sex: 'Женский' } })
        expect(response.status).to eq(302)
        expect(response).to redirect_to(Person.last)
        expect(flash[:success]).to eq('Человек был успешно создан.')
      end
    end

    context 'when new record will not be created' do
      it 'renders new view with errors' do
        expect do
          post(:create, params: { person: { last_name: 'Агафонова', middle_name: 'Борисовна', sex: 'Женский' } })
        end.to change(Person, :count).by(0)

        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
        expect(response.body).to match('не может быть пустым')
      end
    end
  end

  describe '#edit' do
    context 'when editing person form will be created' do
      let!(:person) do
        FactoryBot.create(:person, first_name: 'Вера', last_name: 'Самсонова', middle_name: 'Григорьевна',
                                   sex: 'Женский', full_name: 'Самсонова Вера Григорьевна')
      end

      before(:each) { get(:edit, params: { id: person.id }) }

      it 'assigns person to @person' do
        expect(assigns(:person)).to_not be_nil
        expect(assigns(:person)).to be_an_instance_of(Person)
        expect(assigns(:person)).to have_attributes(first_name: 'Вера', last_name: 'Самсонова',
                                                    middle_name: 'Григорьевна', sex: 'Женский',
                                                    full_name: 'Самсонова Вера Григорьевна')
      end

      it 'renders edit view' do
        expect(response.status).to eq(200)
        expect(response).to render_template(:edit)
        expect(response.body).to match('Редактировать информацию о человеке')
      end
    end
  end

  describe '#update' do
    let!(:person) { FactoryBot.create(:person) }

    context 'when existing record will be updated' do
      before(:each) do
        put(:update, params: { id: person.id, person: { first_name: 'Варвара', last_name: 'Овчинникова',
                                                        middle_name: 'Викторовна' } })
      end

      it 'updates record' do
        expect(person.reload.first_name).to eq('Варвара')
        expect(person.reload.last_name).to eq('Овчинникова')
        expect(person.reload.middle_name).to eq('Викторовна')
        expect(person.reload.full_name).to eq('Овчинникова Варвара Викторовна')
      end

      it 'redirects to index view' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(person)
        expect(flash[:success]).to eq('Данные о человеке былы успешно обновлены.')
      end
    end

    context 'when existing record will not be updated' do
      let!(:person) do
        FactoryBot.create(:person, first_name: 'Варвара', last_name: 'Овчинникова', middle_name: 'Викторовна',
                                   sex: 'Женский', full_name: 'Овчинникова Варвара Викторовна')
      end

      before(:each) { put(:update, params: { id: person.id, person: { first_name: '' } }) }

      it 'does not update record' do
        expect(person.reload.first_name).to_not eq('')
      end

      it 'renders edit view' do
        expect(response.status).to eq(200)
        expect(response).to render_template(:edit)
        expect(response.body).to match('Редактировать информацию о человеке')
        expect(response.body).to match('не может быть пустым')
      end
    end
  end

  describe '#destroy' do
    let!(:person) { FactoryBot.create(:person) }

    context 'when person will be destroyed' do
      it 'successfully destroys person' do
        expect do
          delete(:destroy, params: { id: person.id })
        end.to change { Person.count }.from(1).to(0)
      end

      it 'redirects to index view' do
        delete(:destroy, params: { id: person.id })
        expect(response.status).to eq(302)
        expect(response).to redirect_to(people_path)
        expect(flash[:success]).to eq('Человек был успешно удалён.')
      end
    end
  end
end
