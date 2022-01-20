# frozen_string_literal: true

require_relative '../tag'
require_relative './input_base'

module HexletCode
  module Inputs
    # Textarea class
    class Textarea < InputBase
      def initialize(name, value, options)
        super
        @attributes[:cols] ||= 20
        @attributes[:rows] ||= 40
      end

      protected

      def tag
        'textarea'
      end
    end
  end
end
