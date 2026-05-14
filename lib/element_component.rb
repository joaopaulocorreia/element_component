# frozen_string_literal: true

require_relative "element_component/version"
require_relative "element_component/safe_string"
require_relative "element_component/debug"
require_relative "element_component/element"
require_relative "element_component/components"
require_relative "element_component/aliases"
require_relative "element_component/rails"

module ElementComponent
  class Error < StandardError; end

  class << self
    def debug
      @debug ||= Debugger.new(enabled: ENV["ELEMENT_COMPONENT_DEBUG"] == "true")
    end

    def debug=(value)
      @debug = case value
               when Debugger
                 value
               else
                 Debugger.new(enabled: value)
               end
    end

    def debug_enabled?
      debug.enabled?
    end
  end
end
