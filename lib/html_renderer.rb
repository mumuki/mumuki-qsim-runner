module Qsim
  class HtmlRenderer
    using StringExtension

    def render(result, output)
      @output = output
      @result = result
      if output[:memory]
        memory_range(output).each do |record|
          field = to_4_digits_hex(record)
          @result[:memory].merge!(field => '0000') { |_, old_value, _| old_value }
        end
      end
      template_file.result binding
    end

    private

    def template_file
      ERB.new File.read("#{__dir__}/view/records.html.erb")
    end

    def to_4_digits_hex(number)
      number.to_s(16).rjust(4, '0').upcase
    end

    def memory_range(options)
      from = options[:memory][:from].to_hex
      to = options[:memory][:to].to_hex
      (from..to)
    end
  end
end
