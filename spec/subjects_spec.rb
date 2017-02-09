require 'ostruct'

describe 'Subjects' do
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

  describe '#compile_code' do
    let(:request) { OpenStruct.new(extra: 'NOP', content: 'decrement: SUB AAAA, BBBB') }
    let(:subject_instance) { qsim_subject.new('decrement', request) }
    subject { subject_instance.compile_code('<<<>>>', '') }

    context 'with a subject' do
      let(:qsim_subject) { Qsim::RoutineSubject }

      it { is_expected.to eq(
                              <<~QSIM
                                JMP main

                                NOP
                                decrement: SUB AAAA, BBBB

                                main:
                                CALL decrement
                                <<<>>>

                          QSIM
                          )
      }
    end

    context 'without a subject' do
      let(:qsim_subject) { Qsim::ProgramSubject }

      it { is_expected.to eq(
                              <<~QSIM
                                JMP main

                                NOP

                                main:
                                MOV R0, R0
                                decrement: SUB AAAA, BBBB
                                <<<>>>

                          QSIM
                          )
      }
    end
  end
end
