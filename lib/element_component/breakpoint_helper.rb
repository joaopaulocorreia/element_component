# frozen_string_literal: true

module ElementComponent
  module BreakpointHelper
    VALID_BREAKPOINTS = %i[sm md lg xl xxl].freeze

    def breakpoint_classes(prefix, value)
      return [] unless value

      if value.is_a?(Hash)
        value.flat_map { |bp, val| build_class(prefix, bp, val) }
      else
        [build_single_class(prefix, value)]
      end
    end

    private

    def build_class(prefix, breakpoint, value)
      return build_single_class(prefix, value) if breakpoint == :default

      value == true ? "#{prefix}-#{breakpoint}" : "#{prefix}-#{breakpoint}-#{value}"
    end

    def build_single_class(prefix, value)
      value == true ? prefix : "#{prefix}-#{value}"
    end
  end
end
