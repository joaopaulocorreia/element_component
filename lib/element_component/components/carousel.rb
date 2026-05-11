# frozen_string_literal: true

require_relative "carousel/item"
require_relative "carousel/caption"

module ElementComponent
  module Components
    class Carousel < Element
      def initialize(id: "carousel", fade: false, indicators: true, controls: true, **attributes, &block)
        @carousel_id = id
        @show_indicators = indicators
        @show_controls = controls
        super("div", &block)

        add_attribute(id: id)
        add_attribute(class: "carousel")
        add_attribute(class: "slide")
        add_attribute(class: "carousel-fade") if fade
        add_attribute(attributes) unless attributes.empty?
      end

      private

      def indicator_button(index, active)
        target = "data-bs-target=\"##{@carousel_id}\""
        slide = "data-bs-slide-to=\"#{index}\""
        active_attr = ' class="active" aria-current="true"' if active
        "<button type=\"button\" #{target} #{slide}#{active_attr}></button>"
      end

      def build_indicators
        html = +""
        contents.each_with_index do |item, index|
          next unless item.is_a?(CarouselItem)

          active = item.attributes[:class]&.include?("active") || index.zero?
          html << indicator_button(index, active)
        end
        html
      end

      def control_button(direction, label)
        target = "data-bs-target=\"##{@carousel_id}\""
        slide = "data-bs-slide=\"#{direction}\""
        "<button class=\"carousel-control-#{direction}\" type=\"button\" #{target} #{slide}>" \
          "<span class=\"carousel-control-#{direction}-icon\" aria-hidden=\"true\"></span>" \
          "<span class=\"visually-hidden\">#{label}</span></button>"
      end

      def build
        @html << "<#{@element}"
        @html << (mount_attributes.empty? ? ">" : " #{mount_attributes}>")

        @html << "<div class=\"carousel-indicators\">#{build_indicators}</div>" if @show_indicators

        @html << "<div class=\"carousel-inner\">"
        @html << mount_content
        @html << "</div>"

        if @show_controls
          @html << control_button("prev", "Previous")
          @html << control_button("next", "Next")
        end

        @html << "</#{@element}>" if @closing_tag
        @html
      end
    end
  end
end
