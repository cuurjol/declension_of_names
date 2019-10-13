require 'rails_helper'

describe CreateFullNameService do
  describe '#call' do
    let(:params) { { first_name: 'Вера', last_name: 'Самсонова', middle_name: 'Григорьевна' } }

    it 'returns full name' do
      expect(CreateFullNameService.call(params)).to eq('Самсонова Вера Григорьевна')
    end
  end
end
