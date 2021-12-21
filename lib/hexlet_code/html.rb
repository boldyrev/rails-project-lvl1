# frozen_string_literal: true

require "erb"

TAG_TEMPLATE = <<-HTML.gsub(/(^  )|\n/, "")
  <<%= name %><% unless attributes.empty? %> <%= attributes %><% end %>>
  <% if value %><%= value %><% end %>
  <% unless single %></<%= name %>><% end %>
HTML

FORM_TEMPLATE = <<-HTML.gsub(/^  /, "").strip
  <form action="<%= options[:action] %>" method="<%= options[:method] %>">
  <% options[:elements].each do |f| %>
    <%= tag(f.delete(:tag), **f) %>
  <% end %>
  </form>
HTML

# Html module
module Html
  class << self
    def tag(name, **attributes)
      single = single? name
      value = attributes.delete(:value) unless single
      attributes = attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      ERB.new(TAG_TEMPLATE).result(binding)
    end

    def form(options = {})
      ERB.new(FORM_TEMPLATE, trim_mode: "<>").result(binding)
    end

    def single?(tag)
      %w[br input img hr].include? tag
    end
  end
end
