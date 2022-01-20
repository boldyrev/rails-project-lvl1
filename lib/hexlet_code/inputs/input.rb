# frozen_string_literal: true

require_relative './input_base'

module HexletCode
  module Inputs
    # Input class
    class Input < InputBase
      def initialize(name, value, options)
        super
        @attributes[:type] ||= 'text'
        @attributes = @attributes.sort.to_h
      end
    end
  end
end
