# frozen_string_literal: true

require_relative '../tag'
require_relative './input_base'

module HexletCode
  module Inputs
    # Textarea class
    class Text < InputBase
      def initialize(name, value, options)
        super
        @attributes[:cols] ||= 20
        @attributes[:rows] ||= 40
      end

      def create
        value = @attributes.delete(:value)
        input = Tag.build('textarea', **@attributes) { value }
        "#{label_tag}\n  #{input}"
      end
    end
  end
end
