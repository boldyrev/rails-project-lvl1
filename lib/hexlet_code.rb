# frozen_string_literal: true

require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/field_list'
require_relative 'hexlet_code/errors'

# HexletCode class
module HexletCode
  def self.form_for(user, **options)
    msg = 'It is not allowed to call a form_for method without passing a block'
    raise NoBlockGivenError, msg unless block_given?

    fields = FieldList.new(user)
    yield fields
    Tag.build('form', action: options[:url] || '#', method: 'post') { "#{fields.all.join("\n  ")}\n" }
  end
end
