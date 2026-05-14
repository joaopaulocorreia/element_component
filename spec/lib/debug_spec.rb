# frozen_string_literal: true

RSpec.describe ElementComponent::Debugger do
  subject(:debugger) { described_class.new }

  describe "#log" do
    it "does not log when disabled" do
      debugger.log(:test, "message")
      expect(debugger.events).to be_empty
    end

    it "logs entries when enabled" do
      debugger.enable!
      debugger.log(:test, "hello", foo: 1)
      expect(debugger.events.count).to eq(1)
      expect(debugger.events.first[:category]).to eq(:test)
      expect(debugger.events.first[:message]).to eq("hello")
      expect(debugger.events.first[:data]).to eq({ foo: 1 })
    end
  end

  describe "#enable! / #disable! / #enabled?" do
    it "starts disabled" do
      expect(debugger).not_to be_enabled
    end

    it "enables and disables" do
      debugger.enable!
      expect(debugger).to be_enabled
      debugger.disable!
      expect(debugger).not_to be_enabled
    end
  end

  describe "#clear!" do
    it "clears all events" do
      debugger.enable!
      debugger.log(:a, "1")
      debugger.log(:b, "2")
      debugger.clear!
      expect(debugger.events).to be_empty
    end
  end
end

RSpec.describe "ElementComponent debug integration" do
  before do
    ElementComponent.debug = false
  end

  describe "per-instance debug mode" do
    subject(:element) { ElementComponent::Element.new("p") }

    it "is disabled by default" do
      expect(element).not_to be_debug_mode
    end

    it "enables via debug_mode!" do
      element.debug_mode!
      expect(element).to be_debug_mode
    end

    it "populates debug_events during operations" do
      element.debug_mode!
      element.add_content("hello")
      element.render

      events = element.debug_info[:debug_events]
      expect(events).not_to be_empty
    end

    it "records content event" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_content("test")
      events = el.debug_info[:debug_events]
      expect(events.select { |e| e[:category] == :content }.map { |e| e[:message] })
        .to include(a_string_matching(/test/))
    end

    it "records attribute event" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_attribute(class: "btn")
      events = el.debug_info[:debug_events]
      expect(events.select { |e| e[:category] == :attribute }.map { |e| e[:message] })
        .to include(a_string_matching(/class/))
    end

    it "records render events on render call" do
      el = ElementComponent::Element.new("p").debug_mode!
      el.add_content("hello")
      el.render
      events = el.debug_info[:debug_events]
      categories = events.map { |e| e[:category] }
      expect(categories).to include(:render)
      expect(categories).to include(:opening_tag)
      expect(categories).to include(:closing_tag)
    end

    it "records cache events when cache is enabled" do
      el = ElementComponent::Element.new("p").debug_mode!
      el.cache
      el.render
      events = el.debug_info[:debug_events]
      expect(events.select { |e| e[:category] == :cache }.map { |e| e[:message] })
        .to include(a_string_matching(/MISS/))
    end

    it "records cache HIT on second render" do
      el = ElementComponent::Element.new("p").debug_mode!
      el.add_content("hello")
      el.cache
      el.render
      el.render
      events = el.debug_info[:debug_events]
      expect(events.select { |e| e[:category] == :cache }.map { |e| e[:message] })
        .to include(a_string_matching(/HIT/))
    end

    it "records escape event for string content" do
      el = ElementComponent::Element.new("p").debug_mode!
      el.add_content("<script>")
      el.render
      events = el.debug_info[:debug_events]
      expect(events.select { |e| e[:category] == :escape }).not_to be_empty
    end

    it "records content_type events during render" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_content("text")
      el.add_content(ElementComponent::Element.new("span"))
      el.render
      events = el.debug_info[:debug_events]
      types = events.select { |e| e[:category] == :content_type }
      expect(types.map { |e| e[:type] }).to include("Element")
      expect(types.map { |e| e[:type] }).to include("String")
    end

    it "does not record events when debug is off" do
      element.add_content("hello")
      element.render
      expect(element.debug_info[:debug_events]).to be_empty
    end
  end

  describe "global debug mode" do
    before { ElementComponent.debug = true }
    after { ElementComponent.debug = false }

    it "logs to stdout via Debugger" do
      expect { ElementComponent::Element.new("p").render }
        .to output(/\[.*\]/).to_stdout
    end

    it "uses ElementComponent.debug_enabled?" do
      expect(ElementComponent).to be_debug_enabled
    end
  end

  describe "#debug_info" do
    subject(:el) { ElementComponent::Element.new("div", "content", class: "box").debug_mode! }

    it "returns a hash with element name" do
      expect(el.debug_info[:element]).to eq("div")
    end

    it "returns attributes" do
      expect(el.debug_info[:attributes]).to eq({ class: ["box"] })
    end

    it "returns contents description" do
      expect(el.debug_info[:contents]).to eq(["String"])
    end

    it "returns html_safe status" do
      el.html_safe
      expect(el.debug_info[:html_safe]).to be true
    end

    it "returns debug_enabled status" do
      expect(el.debug_info[:debug_enabled]).to be true
    end

    it "includes debug_events array" do
      expect(el.debug_info[:debug_events]).to be_an(Array)
    end
  end

  describe "debug_info content descriptions" do
    it "describes Element content" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_content(ElementComponent::Element.new("span"))
      info = el.debug_info
      expect(info[:contents].first).to match(/#<Element span>/)
    end

    it "describes Proc content" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_content { |b| b << "x" }
      info = el.debug_info
      expect(info[:contents].first).to eq("<Proc>")
    end

    it "describes SafeString content" do
      el = ElementComponent::Element.new("div").debug_mode!
      el.add_content(ElementComponent.html_safe("<b>bold</b>"))
      info = el.debug_info
      expect(info[:contents].first).to match(/SafeString/)
    end
  end

  describe "ELEMENT_COMPONENT_DEBUG env var" do
    it "enables debug when set to true" do
      ElementComponent.remove_instance_variable(:@debug) if ElementComponent.instance_variable_defined?(:@debug)
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("ELEMENT_COMPONENT_DEBUG").and_return("true")
      expect(ElementComponent.debug).to be_enabled
    end

    it "disables debug when unset" do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("ELEMENT_COMPONENT_DEBUG").and_return(nil)
      debugger = ElementComponent.debug
      expect(debugger).not_to be_enabled
    end
  end
end
