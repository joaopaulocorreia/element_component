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
  end
end
