# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  # Tag class
  module Tag
    def self.build(tag, **attributes)
      return "<#{tag}>" if attributes.empty?

      "<#{tag} #{attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")}>"
    end

    def self.single_tags
      %w[b img]
    end
  end
end
