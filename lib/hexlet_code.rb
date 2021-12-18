# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # Tag class
  module Tag
    OFFSET = 2

    class << self
      def build(tag, **attributes)
        return create_single(tag, **attributes) if single? tag

        value = if block_given?
                  yield
                else
                  attributes.delete(:value)
                end

        "#{create_single(tag, **attributes)}#{value}</#{tag}>"
      end

      def form_for(user, **options)
        @user = user
        url = options[:url] || "#"
        @form = "<form action=\"#{url}\" method=\"post\">\n"
        yield Tag if block_given?
        @form += "</form>"
      end

      def input(field, **options)
        options[:name] = field.to_s
        options[:type] = "text"
        options[:value] = @user.public_send(field)

        tag = if options[:as] == :text
                textarea(**options)
              else
                build("input", **options)
              end

        @form += " " * OFFSET unless @form.empty?
        @form += "#{tag}\n"
      end

      def textarea(**options)
        options.delete(:type)
        options.delete(:as)
        options = { cols: 20, rows: 40 }.merge(options)
        build("textarea", **options)
      end

      def submit(**options)
        options[:type] = "submit"
        build("input", **options)
      end

      def single?(tag)
        %w[br input img hr].include? tag
      end

      def create_single(tag, **attributes)
        return "<#{tag}>" if attributes.empty?

        "<#{tag} #{attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")}>"
      end
    end
  end
end
