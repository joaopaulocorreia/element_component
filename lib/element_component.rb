# frozen_string_literal: true

require_relative "element_component/version"
require_relative "element_component/safe_string"
require_relative "element_component/element"
require_relative "element_component/components"
require_relative "element_component/aliases"
require_relative "element_component/rails"

module ElementComponent
  class Error < StandardError; end
end
