require 'rails_helper'

describe DeclensionNameService do
  let(:person) do
    FactoryBot.create(:person, first_name: 'Вера', last_name: 'Самсонова', middle_name: 'Григорьевна',
                               sex: 'Женщина', full_name: 'Самсонова Вера Григорьевна')
  end

  describe '#call' do
    context 'when a new person is created' do
      it 'creates new declension name record' do
        expect { DeclensionNameService.call(person) }.to change(DeclensionName, :count).from(0).to(1)

        declension_name = DeclensionName.last
        expect(declension_name.person).to eq(person)
        expect(declension_name.genitive).to eq(last_name: 'Самсоновой', first_name: 'Веры', middle_name: 'Григорьевны',
                                               full_name: 'Самсоновой Веры Григорьевны')
        expect(declension_name.dative).to eq(last_name: 'Самсоновой', first_name: 'Вере', middle_name: 'Григорьевне',
                                             full_name: 'Самсоновой Вере Григорьевне')
        expect(declension_name.accusative).to eq(last_name: 'Самсонову', first_name: 'Веру', middle_name: 'Григорьевну',
                                                 full_name: 'Самсонову Веру Григорьевну')
        expect(declension_name.instrumental).to eq(last_name: 'Самсоновой', first_name: 'Верой',
                                                   middle_name: 'Григорьевной',
                                                   full_name: 'Самсоновой Верой Григорьевной')
        expect(declension_name.prepositional).to eq(last_name: 'Самсоновой', first_name: 'Вере',
                                                    middle_name: 'Григорьевне',
                                                    full_name: 'Самсоновой Вере Григорьевне')
      end
    end

    context 'when an existing person is updated' do
      let!(:declension_name) { FactoryBot.create(:declension_name) }

      it 'updates existing declension name record' do
        person = Person.last
        person.update(first_name: 'Оксана', last_name: 'Ларионова', middle_name: 'Олеговна')

        expect { DeclensionNameService.call(person) }.to change(DeclensionName, :count).by(0)

        declension_name.reload
        expect(declension_name.person).to eq(person)
        expect(declension_name.genitive).to eq(last_name: 'Ларионовой', first_name: 'Оксаны', middle_name: 'Олеговны',
                                               full_name: 'Ларионовой Оксаны Олеговны')
        expect(declension_name.dative).to eq(last_name: 'Ларионовой', first_name: 'Оксане', middle_name: 'Олеговне',
                                             full_name: 'Ларионовой Оксане Олеговне')
        expect(declension_name.accusative).to eq(last_name: 'Ларионову', first_name: 'Оксану', middle_name: 'Олеговну',
                                                 full_name: 'Ларионову Оксану Олеговну')
        expect(declension_name.instrumental).to eq(last_name: 'Ларионовой', first_name: 'Оксаной',
                                                   middle_name: 'Олеговной', full_name: 'Ларионовой Оксаной Олеговной')
        expect(declension_name.prepositional).to eq(last_name: 'Ларионовой', first_name: 'Оксане',
                                                    middle_name: 'Олеговне', full_name: 'Ларионовой Оксане Олеговне')
      end
    end
  end
end
