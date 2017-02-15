module StringExtension
  refine String do
    def to_hex
      to_i(16)
    end
  end
end
