# frozen_string_literal: true

module HexletCode
  # Tag module
  module Tag
    class << self
      def build(tag, **attributes)
        attributes[:value] = yield if block_given?
        Html.tag(tag, **attributes)
      end
    end
  end
end
