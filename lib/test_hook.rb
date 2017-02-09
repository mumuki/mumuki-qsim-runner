class QsimTestHook < Mumukit::Templates::FileHook
  include Mumukit::WithTempfile
  attr_reader :examples

  isolated

  def tempfile_extension
    '.qsim'
  end

  def command_line(filename)
    "runqsim #{filename} #{q_architecture} #{input_file_separator}"
  end

  def compile_file_content(request)
    test = parse_test(request)
    @examples = to_examples(test[:examples])
    @subject = test[:subject]

    Qsim::Subject
        .from_test(test, request)
        .compile_code(input_file_separator, initial_state_file)
  end

  def execute!(request)
    result, _ = run_file! compile request
    parse_json result
  end

  def post_process_file(_file, result, status)
    output = parse_json result

    case status
      when :passed
        framework.test output, @examples
      when :failed
        [output[:error], :errored]
      else
        [output, status]
    end
  end

  private

  def to_examples(examples)
    examples.each_with_index.map do |example, index|
      example[:preconditions] = classify(example.fetch(:preconditions, {}))
      example.merge(id: index)
    end
  end

  def classify(fields)
    classified_fields = {}
    fields.map do |key, value|
      field = key.to_s
      classified_fields.deep_merge!(records: {key => value}) if record?(field)
      classified_fields.deep_merge!(flags: {key => value}) if flag?(field)
      classified_fields.deep_merge!(memory: {key => value}) if memory?(field)
      classified_fields.deep_merge!(special_records: {key => value}) if special_record?(field)
    end
    classified_fields
  end

  def record?(key)
    key.start_with? 'R'
  end

  def flag?(key)
    %q(N C V Z).include? key
  end

  def memory?(key)
    /^[A-F0-9]/.matches?(key)
  end

  def special_record?(key)
    %q(SP PC IR).include? key
  end

  def framework
    Mumukit::Metatest::Framework.new checker: Qsim::Checker.new,
                                     runner: Qsim::MultipleExecutionsRunner.new
  end

  def parse_json(json_result)
    JSON.parse(json_result).map(&:deep_symbolize_keys)
  end

  def parse_test(request)
    YAML.load(request.test).deep_symbolize_keys
  end

  def default_initial_state
    {
        special_records: {
            PC: '0000',
            SP: 'FFEF',
            IR: '0000'
        },
        flags: {
            N: 0,
            Z: 0,
            V: 0,
            C: 0
        },
        records: {
            R0: '0000',
            R1: '0000',
            R2: '0000',
            R3: '0000',
            R4: '0000',
            R5: '0000',
            R6: '0000',
            R7: '0000'
        },
        memory: {}
    }
  end

  def initial_state_file
    initial_states = @examples.map do |example|
      default_initial_state
          .merge(id: example[:id])
          .deep_merge(example[:preconditions])
    end
    JSON.generate(initial_states)
  end

  def q_architecture
    6
  end

  def input_file_separator
    '!!!BEGIN_EXAMPLES!!!'
  end
end
