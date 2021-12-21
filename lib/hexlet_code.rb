# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "hexlet_code/html"

module HexletCode
  class Error < StandardError; end

  # Tag module
  module Tag
    class << self
      def build(tag, **attributes)
        attributes[:value] = yield if block_given?
        Html.tag(tag, **attributes)
      end

      def form_for(user, **options)
        @user = user
        @form = {
          action: options[:url] || "#",
          method: "post",
          elements: []
        }
        yield Tag if block_given?
        Html.form(@form)
      end

      def input(field, **options)
        add_label field.to_s
        element = {
          tag: "input",
          name: field.to_s,
          type: "text"
        }

        options[:as] == :text && to_textarea(element)
        element[:value] = @user.public_send(field)
        @form[:elements].push(element)
      end

      def submit(title = "Save")
        element = {
          tag: "input",
          name: "commit",
          type: "submit",
          value: title
        }
        @form[:elements].push(element)
      end

      def add_label(name)
        element = {
          tag: "label",
          for: name,
          value: name.capitalize
        }

        @form[:elements].push(element)
      end

      def to_textarea(element)
        element.delete(:type)
        element[:tag] = "textarea"
        element[:cols] = 20
        element[:rows] = 40
      end
    end
  end
end
