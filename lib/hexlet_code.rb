# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # Tag class
  module Tag
    class << self
      def build(tag, **attributes)
        return "<#{tag}>" if attributes.empty?

        "<#{tag} #{attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")}>"
      end

      def form_for(_, **options)
        url = options[:url] || "#"
        <<-HTML.strip
          <form action="#{url}" method="post"></form>
        HTML
      end

      def single_tags
        %w[b img]
      end
    end
  end
end
