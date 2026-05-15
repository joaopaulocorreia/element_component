# frozen_string_literal: true

require_relative "breadcrumb"
require_relative "item"
require_relative "list"

module ElementComponent
  module Components
    module Breadcrumb
      class Component
        attr_reader :breadcrumb

        def initialize(items: [])
          @breadcrumb = Breadcrumb.new
          items.each { |item| @breadcrumb.add_content Item.new(item[:content], active: item[:active] || false) }
        end

        def render
          breadcrumb.render
        end

        def render_in
          breadcrumb.render_in
        end

        def cache(...)
          breadcrumb.cache(...)
        end

        def expire_cache!
          breadcrumb.expire_cache!
        end
      end
    end
  end
end
