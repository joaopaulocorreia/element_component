# frozen_string_literal: true

module ElementComponent
  module Components
    class Table < Element
      VALID_VARIANTS = %i[primary secondary success danger warning info light dark].freeze

      def initialize(striped: false, bordered: false, hover: false, small: false, variant: nil, **attributes, &block)
        super("table", &block)

        add_attribute(class: "table")
        add_attribute(class: "table-striped") if striped
        add_attribute(class: "table-bordered") if bordered
        add_attribute(class: "table-hover") if hover
        add_attribute(class: "table-sm") if small
        add_attribute(class: "table-#{variant}") if variant
        add_attribute(attributes) unless attributes.empty?
      end
    end
  end
end
