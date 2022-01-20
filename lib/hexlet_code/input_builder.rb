# frozen_string_literal: true

require_relative 'inputs/textarea'
require_relative 'inputs/input'

module HexletCode
  # Input builder module
  module InputBuilder
    def self.create(name, value, options)
      type = options[:as] == :text ? 'textarea' : 'input'
      label = options[:label] != false
      input_cls = Inputs.const_get(type.capitalize)
      input = input_cls.new(name, value, options.except(:as, :label))
      input.create(label: label)
    end
  end
end
