module Fixture
  def save_to_memory_program
    <<~QSIM
      MOV [0x1234], 0x0010
    QSIM
  end

  def save_to_memory_program_examples
    <<~EXAMPLE
      examples:
      - name: '[0x1234] is 0010'
        preconditions:
         {}
        postconditions:
          equal:
            1234: '0010'
    EXAMPLE
  end
end
