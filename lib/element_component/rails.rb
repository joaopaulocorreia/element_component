# frozen_string_literal: true

module ElementComponent
  module RailsHelpers
    def view_context=(value)
      @view_context = value
    end

    def view_context
      @view_context
    end

    def helpers
      @view_context
    end

    def respond_to_missing?(method_name, include_private = false)
      @view_context.respond_to?(method_name, include_private) || super
    end

    def method_missing(method_name, ...)
      if @view_context.respond_to?(method_name)
        @view_context.public_send(method_name, ...)
      else
        super
      end
    end
  end
end
