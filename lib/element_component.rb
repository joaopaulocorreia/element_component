# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative "element_component/version"
require_relative "element_component/element"
require_relative "element_component/form/input"
require_relative "element_component/form/form"

# Bulma CSS
require_relative "element_component/bulma/breadcrumb"

module ElementComponent
  class Error < StandardError; end
  # Your code goes here...
end
