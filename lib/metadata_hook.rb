class QsimMetadataHook < Mumukit::Hook
  def metadata
    {
      language: {
        name: 'qsim',
        icon: { type: 'devicon', name: 'qsim' },
        version: 'v0.2.2',
        extension: 'qsim',
        ace_mode: 'assembly_x86',
        graphic: true
      },
      test_framework: {
        name: 'metatest',
        test_extension: 'yml',
        template: <<qsim
examples:
- name: '{{ test_template_group_description }}'
  preconditions:
    records:
      R0: '0001'
      R1: '000A'
  postconditions:
    equal:
      R0: '0001'
      R1: '000A'
qsim
      }
    }
  end
end
