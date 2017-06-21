module Fixture
  def multiple_checks_program
    <<~QSIM
      MOV R0,R0
    QSIM
  end

  def multiple_checks_program_examples
    <<~EXAMPLE
      examples:
      - name: 'Nothing is changed'
        preconditions:
         R1: '0002'
         'AAAA': '0002'
        postconditions:
          equal:
            R1: '0002'
            'AAAA': '0002'
            'BBBB': '0000'
    EXAMPLE
  end
end
