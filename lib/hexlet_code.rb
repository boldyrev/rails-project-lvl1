# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/html'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/field_list'
require_relative 'hexlet_code/errors'

# HexletCode class
module HexletCode
  def self.form_for(user, **options)
    msg = 'It is not allowed to call a form_for method without passing a block'
    raise NoBlockGivenError, msg unless block_given?

    form = {
      action: options[:url] || '#',
      method: 'post'
    }

    fields = FieldList.new(user)
    yield fields
    form[:elements] = fields.all
    Html.form(form)
  end
end
