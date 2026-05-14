# frozen_string_literal: true

require_relative "navbar/brand"
require_relative "navbar/toggler"
require_relative "navbar/collapse"
require_relative "navbar/nav"

module ElementComponent
  module Components
    class Navbar < Element
      VALID_EXPAND = %i[sm md lg xl xxl].freeze
      VALID_THEMES = %i[light dark].freeze
      VALID_FIXED = %i[top bottom].freeze
      VALID_STICKY = %i[top bottom].freeze

      def initialize(content = nil, expand: :lg, theme: :light, background: nil, fixed: nil, sticky: nil, container: true, **attributes,
                     &block)
        super("nav", &block)

        add_attribute(class: "navbar")
        add_attribute(class: "navbar-expand-#{expand}")
        add_attribute(class: "navbar-#{theme}")
        add_attribute(class: "bg-#{background}") if background
        add_attribute(class: "fixed-#{fixed}") if fixed
        add_attribute(class: "sticky-#{sticky}") if sticky
        add_attribute(attributes) unless attributes.empty?

        @use_container = container
        add_content(content) if content
      end

      private

      def build
        @html << opening_tag

        if @use_container
          container_class = @use_container == true ? "container-fluid" : "container"
          @html << "<div class=\"#{container_class}\">"
        end

        @html << mount_content(contents)

        @html << "</div>" if @use_container

        @html << closing_tag
        @html
      end
    end
  end
end
