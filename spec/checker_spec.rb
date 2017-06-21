describe Qsim::Checker do
  describe '#check_equal' do
    context 'given correct expectations' do
      it 'does not fail' do
        result = check('0000': '0000', '0001': '0001', R0: '0000')
        expect(result).to be_truthy
      end
    end

    context 'given incorrect expectations' do
      it 'fails with Mumukit::Metatest::Failed' do
        expect { check(R0: '0001') }.to raise_exception Mumukit::Metatest::Failed
      end
    end

    def check(records)
      result = {
        flags: {},
        memory: { '0001': '0001' },
        records: { R0: '0000' }
      }
      Qsim::Checker.new.check_equal(result, records)
    end
  end
end
