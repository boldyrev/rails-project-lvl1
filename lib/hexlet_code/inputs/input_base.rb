# frozen_string_literal: true

require_relative '../tag'

module HexletCode
  module Inputs
    # Base input class
    class InputBase
      def initialize(name, value, options)
        @attributes = { name: name, value: value, **options }
      end

      protected

      def tag
        'input'
      end

      def label_tag
        name = @attributes[:name]
        Tag.build('label', for: name) { name.capitalize }
      end
    end
  end
end
