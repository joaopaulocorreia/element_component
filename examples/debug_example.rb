# frozen_string_literal: true

require_relative "../lib/element_component"

E = ElementComponent::E
EC = ElementComponent::Components

# =============================================================================
# 1. Per-instância: debug_mode! em um componente Bootstrap
# =============================================================================
puts "=" * 70
puts "1. PER-INSTÂNCIA DEBUG"
puts "=" * 70

alert = EC::Alert.new(variant: :danger, dismissible: true).debug_mode!
alert.add_content("Falha na operação!")

puts alert.render

info = alert.debug_info
puts "\ndebug_info keys: #{info.keys}"
puts "element: #{info[:element]}"
puts "total events: #{info[:debug_events].count}"
categories = info[:debug_events].map { |e| e[:category] }.uniq
puts "categories: #{categories.join(", ")}"

# =============================================================================
# 2. Global: todos os elementos traçam para stdout
# =============================================================================
puts "\n#{"=" * 70}"
puts "2. GLOBAL DEBUG"
puts "=" * 70

ElementComponent.debug = true

div = ElementComponent::Element.new("div", class: "container")
div.add_content("<script>alert('xss')</script>")
div.add_content(ElementComponent.html_safe("<b>negrito</b>"))
div.render

ElementComponent.debug = false

# =============================================================================
# 3. Cache HIT/MISS com debug
# =============================================================================
puts "\n#{"=" * 70}"
puts "3. CACHE TRACE"
puts "=" * 70

cached = ElementComponent::Element.new("p").debug_mode!
cached.add_content("expensive content")
cached.cache(expires_in: 60)

puts "\n--- Primeiro render (MISS) ---"
puts cached.render

puts "\n--- Segundo render (HIT) ---"
puts cached.render

puts "\n--- Expira cache, terceiro render ---"
cached.expire_cache!
cached.cache
puts cached.render

events = cached.debug_info[:debug_events]
cache_events = events.select { |e| e[:category] == :cache }
cache_events.each do |e|
  puts "  [#{e[:category]}] #{e[:message]}"
end

# =============================================================================
# 4. Aninhamento e content_type
# =============================================================================
puts "\n#{"=" * 70}"
puts "4. NESTED ELEMENTS & CONTENT TYPES"
puts "=" * 70

parent = ElementComponent::Element.new("div").debug_mode!
parent.add_content("texto direto")
parent.add_content(ElementComponent::Element.new("span") { |b| b << "filho" })
parent.add_content { |b| b << ElementComponent::Element.new("em") { |b2| b2 << "itálico" } }
parent.add_content(ElementComponent.html_safe("<hr>"))

puts parent.render

info = parent.debug_info
puts "\ncontents description:"
info[:contents].each { |c| puts "  #{c}" }

puts "\ncontent_type events:"
info[:debug_events]
  .select { |e| e[:category] == :content_type }
  .each { |e| puts "  type=#{e[:type]}#{" tag=#{e[:tag]}" if e[:tag]}" }

# =============================================================================
# 5. Hooks com debug
# =============================================================================
puts "\n#{"=" * 70}"
puts "5. RENDERING HOOKS"
puts "=" * 70

hook_el = ElementComponent::Element.new("div").debug_mode!
hook_el.define_singleton_method(:before_render) { add_attribute(class: "dynamic") }
hook_el.add_content("hook content")
puts hook_el.render

hook_events = hook_el.debug_info[:debug_events].select { |e| e[:category] == :hook }
hook_events.each { |e| puts "  [#{e[:category]}] #{e[:message]}" }

# =============================================================================
# 6. Atributos com debug
# =============================================================================
puts "\n#{"=" * 70}"
puts "6. ATTRIBUTE TRACE"
puts "=" * 70

btn = ElementComponent::Element.new("button").debug_mode!
btn.add_attribute(class: "btn")
btn.add_attribute(class: "btn-primary")
btn.add_attribute(type: "submit")
btn.remove_attribute_value(:class, "btn")
puts btn.render

attr_events = btn.debug_info[:debug_events].select { |e| e[:category] == :attribute }
attr_events.each { |e| puts "  [#{e[:category]}] #{e[:message]}" }
