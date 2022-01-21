# frozen_string_literal: true

require_relative 'inputs/text'
require_relative 'inputs/input'

module HexletCode
  # Input builder module
  module InputBuilder
    def self.create(name, value, options)
      default = 'input'
      input_cls = Inputs.const_get(options.fetch(:as, default).capitalize)
      input = input_cls.new(name, value, options.except(:as))
      input.create
    end
  end
end
