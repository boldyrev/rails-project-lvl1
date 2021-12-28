# frozen_string_literal: true

# Class for storage form inner elements
class FieldList
  attr_reader :all

  def initialize(user)
    @all = []
    @user = user
  end

  def input(field, **options)
    add_label field.to_s
    as = options.delete(:as)
    element = {
      tag: 'input',
      name: field.to_s,
      type: 'text'
    }.merge(options)

    element = to_textarea(element, **options) if as == :text
    element[:value] = @user.public_send(field)
    @all.push(element)
  end

  def submit(title = 'Save')
    element = {
      tag: 'input',
      name: 'commit',
      type: 'submit',
      value: title
    }
    @all.push(element)
  end

  private

  def add_label(name)
    element = {
      tag: 'label',
      for: name,
      value: name.capitalize
    }

    @all.push(element)
  end

  def to_textarea(element, **options)
    element.delete(:type)
    element[:tag] = 'textarea'
    element[:cols] = options[:cols] || 20
    element[:rows] = options[:rows] || 40
    element
  end
end
