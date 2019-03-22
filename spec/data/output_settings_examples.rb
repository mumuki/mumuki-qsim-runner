module Fixture
  def group_settings_example
    <<~EXAMPLE
      examples:
      - name: 'R1 is 0008'
        preconditions:
         R1: '0008'
        postconditions:
          equal:
            R1: '0008'
      - name: 'R2 is 0008'
        preconditions:
         R2: '0008'
        postconditions:
          equal:
            R2 '0008'
      output:
        special_records: true
    EXAMPLE
  end

  def individual_settings_example
    <<~EXAMPLE
      examples:
      - name: 'R1 is 0008'
        preconditions:
         R1: '0008'
        postconditions:
          equal:
            R1: '0008'
      - name: 'R2 is 0008'
        preconditions:
         R2: '0008'
        postconditions:
          equal:
            R2 '0008'
        output:
          special_records: true
    EXAMPLE
  end

  def settings_override_example
    <<~EXAMPLE
      examples:
      - name: 'R1 is 0008'
        preconditions:
         R1: '0008'
        postconditions:
          equal:
            R1: '0008'
        output:
          special_records: false
      - name: 'R2 is 0008'
        preconditions:
         R2: '0008'
        postconditions:
          equal:
            R2 '0008'
      output:
        special_records: true
    EXAMPLE
  end
end
