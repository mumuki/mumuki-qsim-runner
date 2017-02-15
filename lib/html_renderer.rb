module Qsim
  class HtmlRenderer
    def render(result)
      @result = result
      template_file.result binding
    end

    private

    def template_file
      ERB.new File.read("#{__dir__}/view/records.html.erb")
    end
  end
end
