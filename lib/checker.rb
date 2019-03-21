module Qsim
  class Checker < Mumukit::Metatest::Checker
    def check(result, example)
      @output_options = example[:output]
      super
    end

    def check_equal(result, state)
      state.each do |target, expected|
        actual = target_value result, target
        fail I18n.t(:check_equal_failure, record: target, expected: expected, actual: actual) unless actual == expected
      end
    end

    def render_success_output(result)
      renderer.render(result, @output_options)
    end

    def render_error_output(result, error)
      "#{error}\n#{renderer.render(result, @output_options)}"
    end

    private

    def target_value(result, target)
      case target
      when /R\d/
        result[:records][target]
      when /[0-9A-F]{4}/
        result[:memory][target]
      else
        error I18n.t :unknown_target, target: target
      end
    end

    def renderer
      @renderer ||= Qsim::HtmlRenderer.new
    end
  end
end
