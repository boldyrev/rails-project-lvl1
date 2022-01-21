# frozen_string_literal: true

require_relative '../tag'

module HexletCode
  module Inputs
    # Base input class
    class InputBase
      def initialize(name, value, options)
        @attributes = { name: name, value: value, **options }
      end

      def create
        if single?(tag)
          input = Tag.build(tag, **@attributes)
        else
          value = @attributes.delete(:value)
          input = Tag.build(tag, **@attributes) { value }
        end
        "#{label_tag}\n  #{input}"
      end

      protected

      def tag
        'input'
      end

      def single?(tag)
        %w[input].include? tag
      end

      def label_tag
        name = @attributes[:name]
        Tag.build('label', for: name) { name.capitalize }
      end
    end
  end
end
