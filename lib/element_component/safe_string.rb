# frozen_string_literal: true

module ElementComponent
  class SafeString < String
    def html_safe? = true
    def to_s = self
  end

  def self.html_safe(string) = SafeString.new(string.to_s)
end
