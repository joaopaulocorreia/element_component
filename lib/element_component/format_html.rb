# frozen_string_literal: true

require "htmlbeautifier"

module ElementComponent
  def self.format_html(html, indent: 2)
    return "" if html.nil? || html.empty?

    HtmlBeautifier.beautify(html.to_s, indent: " " * indent)
  end
end
