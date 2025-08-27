# frozen_string_literal: true

module ElementComponent
  module Core
    class Maker
      def method_missing(method, **args, &block)
        new_element = ElementComponent::Element.new(method.to_s.gsub("_", "-"), **args)
        block.call new_element if block_given?
        new_element
      end
    end
  end
end
