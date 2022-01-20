# frozen_string_literal: true

require_relative './html'

module HexletCode
  # Tag module
  module Tag
    def self.build(tag, **attributes, &block)
      Html.render(tag, attributes, block)
    end
  end
end
