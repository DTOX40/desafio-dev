require 'rails_helper'

RSpec.describe ParseCnabTransaction do
  describe '#execute' do
    let(:path) { Rails.root.join('spec', 'fixtures', 'cnab_file.txt') }
    let(:service) { described_class.new(path) }

    before do
      allow(File).to receive(:open).and_return(
        StringIO.new(
          "3201903010000013200556418150633123****7687145607MARCOS PEREIRAMERCADO DA AVENIDA\r\n"
        )
      )
    end

    it 'parses and creates CnabTransaction records' do
      expect {
        service.execute
      }.to change(CnabTransaction, :count).by(1)
    end

    it 'returns an array of errors if record creation fails' do
      allow(CnabTransaction).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
      
      service.execute

      expect(service.errors).to be_present
    end
  end
end
