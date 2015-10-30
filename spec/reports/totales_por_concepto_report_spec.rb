require_relative '../spec_helper'

describe TotalesPorConceptoReport do
  let(:empresa) { double(:empresa) }

  context 'cuando no hay recibos en la empresa,' do
    before :each do
      allow(empresa).to receive(:recibos).and_return([])
    end

    describe '#recibos,' do
      it 'devuelve []' do
        report = TotalesPorConceptoReport.new(empresa, Date.new(2015, 1, 1), Date.new(2015, 1, 31))
        expect(report.recibos).to be_empty
      end

      it '#sueldo_basico es 0' do
        report = TotalesPorConceptoReport.new(empresa, Date.new(2015, 1, 1), Date.new(2015, 1, 31))
        expect(report.sueldo_basico).to eq 0
      end
    end
  end

  context 'cuando existen recibos en la empresa,' do

  end
end
