# frozen_string_literal: true

FORM_TEMPLATE = <<-HTML.gsub(/^  /, '').strip
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
      attributes = attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

      result = "<#{name}"
      attributes.empty? || result += " #{attributes}"
      result += '>'
      value && result += value.to_s
      single || result += "</#{name}>"
      result
    end

    def form(options = {})
      result = "<form action=\"#{options[:action]}\" method=\"#{options[:method]}\">\n"
      options[:elements].each do |f|
        result += "  #{tag(f.delete(:tag), **f)}\n"
      end
      result += '</form>'
      result
    end

    def single?(tag)
      %w[br input img hr].include? tag
    end
  end
end
