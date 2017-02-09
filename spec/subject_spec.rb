describe Qsim::Subject do
  describe '.from_test' do
    subject { Qsim::Subject.from_test(definition, 'foo') }

    context 'given a subject' do
      let(:definition) { {subject: 'foo'} }
      it { is_expected.to be_instance_of Qsim::RoutineSubject }
    end

    context 'without subject' do
      let(:definition) { Hash.new }
      it { is_expected.to be_instance_of Qsim::ProgramSubject }
    end
  end
end