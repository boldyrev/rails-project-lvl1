# frozen_string_literal: true

# Html module
module Html
  class << self
    def render(name, attributes, block)
      attributes = attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

      attributes = " #{attributes}" if attributes

      if block
        inner = block.call
        inner = "\n  #{inner}" if tag? inner
        "<#{name}#{attributes}>#{inner}</#{name}>"
      else
        "<#{name}#{attributes}>"
      end
    end

    def tag?(obj)
      obj.to_s.chomp[0] == '<'
    end
  end
end
