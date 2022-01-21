# frozen_string_literal: true

require_relative './input_builder'
require_relative './tag'

module HexletCode
  # Class for storage form inner elements
  class FieldList
    attr_reader :all

    def initialize(user)
      @all = []
      @user = user
    end

    def input(field, **options)
      value = @user.public_send(field)
      element = InputBuilder.create(field, value, options)
      @all.push(element)
    end

    def submit(title = 'Save')
      element = Tag.build('input', name: 'commit', type: 'submit', value: title)
      @all.push(element)
    end
  end
end
