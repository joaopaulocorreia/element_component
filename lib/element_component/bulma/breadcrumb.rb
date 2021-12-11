module ElementComponent
  module Bulma
    class Breadcrumb < Element
      def initialize(links)
        super('nav')

        add_attribute :class, 'breadcrumb'
        add_attribute 'aria-label', 'breadcrumbs'

        ul = Element.new('ul')
        links.each do |link|
          li = Element.new('li')
          a  = Element.new('a')
          a.add_attribute(:href, link[:url])
          a.add_content(link[:text])

          if link[:active]
            a.add_attribute('aria-current', 'page')
            li.add_attribute(:class, 'is-active')
          end

          li.add_content(a)
          ul.add_content(li)
        end

        add_content(ul)
      end
    end
  end
end
