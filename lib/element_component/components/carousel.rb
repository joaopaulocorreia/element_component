# frozen_string_literal: true

require_relative "carousel/item"
require_relative "carousel/caption"

module ElementComponent
  module Components
    class Carousel < Element
      def initialize(content = nil, id: "carousel", fade: false, indicators: true, controls: true, **attributes, &)
        @carousel_id = id
        @show_indicators = indicators
        @show_controls = controls

        super("div", content, **attributes, &)

        add_attribute(id: id)
        add_attribute(class: "carousel")
        add_attribute(class: "slide")
        add_attribute(class: "carousel-fade") if fade
      end

      private

      def carousel_items
        @contents.grep(CarouselItem)
      end

      def active_index
        carousel_items.index { |item| item.attributes[:class]&.include?("active") } || 0
      end

      def indicator_button(index, active)
        attributes = {
          type: "button",
          "data-bs-target": "##{@carousel_id}",
          "data-bs-slide-to": index.to_s
        }
        if active
          attributes[:class] = "active"
          attributes[:"aria-current"] = "true"
        end

        new_element("button", **attributes)
      end

      def control_button(direction, label)
        new_element("button", class: "carousel-control-#{direction}", type: "button",
                              "data-bs-target": "##{@carousel_id}", "data-bs-slide": direction) do |btn|
          btn << new_element("span", class: "carousel-control-#{direction}-icon", "aria-hidden": "true")
          btn << new_element("span", label, class: "visually-hidden")
        end
      end

      def render_indicators
        active = active_index
        wrapper = new_element("div", class: "carousel-indicators")
        carousel_items.each_index { |index| wrapper << indicator_button(index, index == active) }
        wrapper.render_in(@view_context)
      end

      def render_inner
        new_element("div", contents, class: "carousel-inner").render_in(@view_context)
      end

      def build
        @html << opening_tag
        @html << render_indicators if @show_indicators
        @html << render_inner

        if @show_controls
          @html << control_button("prev", "Previous").render_in(@view_context)
          @html << control_button("next", "Next").render_in(@view_context)
        end

        @html << closing_tag
        @html
      end
    end
  end
end
