require '../lib/element_component'

html = ElementComponent::Element.new('html')
header = ElementComponent::Element.new('header')
html.add_content(header)
body = ElementComponent::Element.new('body')
html.add_content(body)

h1 = ElementComponent::Element.new('h1')
h1.add_content('Hello, World!')
body.add_content(h1)

p html.render
