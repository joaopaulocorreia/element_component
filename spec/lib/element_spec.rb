# frozen_string_literal: true

RSpec.describe ElementComponent::Element do
  subject { ElementComponent::Element.new("p") }

  describe "Create empty element" do
    it "has the correct element name" do
      expect(subject.element).to eq("p")
    end

    it "has empty contents" do
      expect(subject.contents).to eq([])
    end

    it "has empty attributes" do
      expect(subject.attributes).to eq({})
    end

    it "renders an empty element" do
      expect(subject.render).to eq("<p></p>")
    end
  end

  describe "Add content to element" do
    before { subject.add_content("content one") }

    context "One content" do
      it { expect(subject.contents.count).to eq(1) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq("content one") }
      it { expect(subject.render).to eq("<p>content one</p>") }
    end

    context "Two contents" do
      before { subject.add_content("content two") }

      it { expect(subject.contents.count).to eq(2) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq("content one") }
      it { expect(subject.contents.last).to eq("content two") }
      it { expect(subject.render).to eq("<p>content onecontent two</p>") }
    end

    context "When content have type Element" do
      before { subject.add_content(ElementComponent::Element.new("h1")) }

      it { expect(subject.contents.count).to eq(2) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq("content one") }
      it { expect(subject.contents.last.class).to eq(ElementComponent::Element) }
      it { expect(subject.render).to eq("<p>content one<h1></h1></p>") }
    end

    context "Reset contents and add new value" do
      before { subject.add_content!("new content") }

      it { expect(subject.contents.count).to eq(1) }
      it { expect(subject.contents).to eq(["new content"]) }
    end
  end

  describe "Element with block content" do
    subject { ElementComponent::Element.new("div") { |e| e.add_content("block content") } }

    it "renders content from block" do
      expect(subject.contents).to eq(["block content"])
    end

    it "renders block content in HTML" do
      expect(subject.render).to eq("<div>block content</div>")
    end
  end

  describe "Element with Proc content via add_content(&block)" do
    it "renders new_element inside a Proc" do
      element = ElementComponent::Element.new("div")
      element.add_content { |e| e.new_element("p") }
      expect(element.render).to eq("<div><p></p></div>")
    end

    it "renders new_element with content inside a Proc" do
      element = ElementComponent::Element.new("div")
      element.add_content { |e| e.new_element("span").tap { |s| s.add_content("text") } }
      expect(element.render).to eq("<div><span>text</span></div>")
    end

    it "renders Proc returning string" do
      element = ElementComponent::Element.new("div")
      element.add_content { "string from proc" }
      expect(element.render).to eq("<div>string from proc</div>")
    end

    it "renders mixed content with Proc and string" do
      element = ElementComponent::Element.new("div")
      element.add_content("before ")
      element.add_content { |e| e.new_element("em") }
      element.add_content(" after")
      expect(element.render).to eq("<div>before <em></em> after</div>")
    end

    it "renders Proc with add_content returning self gracefully" do
      element = ElementComponent::Element.new("div")
      element.add_content { |e| e.add_content("nested") }
      expect(element.render).to eq("<div></div>")
    end
  end

  describe "new_element with block" do
    it "creates element with block content via constructor DSL" do
      div = ElementComponent::Element.new("div")
      div.add_content(div.new_element("p") { |e| e.add_content("text") })
      expect(div.render).to eq("<div><p>text</p></div>")
    end

    it "creates element with block inside a Proc" do
      div = ElementComponent::Element.new("div")
      div.add_content { |e| e.new_element("span") { |inner| inner.add_content("nested") } }
      expect(div.render).to eq("<div><span>nested</span></div>")
    end

    it "creates nested new_element with chain of blocks" do
      div = ElementComponent::Element.new("div") do |e|
        e.add_content(e.new_element("ul") do |ul|
          ul.add_content(ul.new_element("li") { |li| li.add_content("item") })
        end)
      end
      expect(div.render).to eq("<div><ul><li>item</li></ul></div>")
    end

    it "creates element with block and attributes" do
      div = ElementComponent::Element.new("div") do |e|
        e.add_content(e.new_element("a", href: "/link") { |a| a.add_content("click") })
      end
      expect(div.render).to eq("<div><a href=\"/link\">click</a></div>")
    end
  end

  describe "Add array of contents to element" do
    before { subject.add_content(["item 1", "item 2", "item 3"]) }

    it { expect(subject.contents.count).to eq(3) }
    it { expect(subject.contents).to eq(["item 1", "item 2", "item 3"]) }
    it { expect(subject.render).to eq("<p>item 1item 2item 3</p>") }
  end

  describe "Add array with mixed content types" do
    before do
      subject.add_content(["text", ElementComponent::Element.new("span") { |s| s.add_content("nested") }])
    end

    it { expect(subject.contents.count).to eq(2) }
    it { expect(subject.render).to eq("<p>text<span>nested</span></p>") }
  end

  describe "Add attribute to element" do
    before { subject.add_attribute(class: "margin") }

    context "Add new attribute" do
      it { expect(subject.attributes.key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({ class: ["margin"] }) }
      it { expect(subject.render).to eq('<p class="margin"></p>') }
    end

    context "Add more value to the some attribute" do
      before { subject.add_attribute(class: "color") }

      it { expect(subject.attributes.key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({ class: %w[margin color] }) }
      it { expect(subject.render).to eq('<p class="margin color"></p>') }
    end

    context "Reset attributes and add new value" do
      before { subject.add_attribute!(class: "padding") }

      it { expect(subject.attributes.key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({ class: ["padding"] }) }
      it { expect(subject.render).to eq('<p class="padding"></p>') }
    end
  end

  describe "Element with content argument" do
    context "simple content" do
      subject { ElementComponent::Element.new("p", "Hello World") }

      it { expect(subject.contents).to eq(["Hello World"]) }
      it { expect(subject.render).to eq("<p>Hello World</p>") }
    end

    context "content as array" do
      subject { ElementComponent::Element.new("div", ["item 1", "item 2", "item 3"]) }

      it { expect(subject.contents.count).to eq(3) }
      it { expect(subject.contents).to eq(["item 1", "item 2", "item 3"]) }
      it { expect(subject.render).to eq("<div>item 1item 2item 3</div>") }
    end

    context "content with attributes" do
      subject { ElementComponent::Element.new("span", "text", class: "container") }

      it { expect(subject.contents).to eq(["text"]) }
      it { expect(subject.attributes).to eq({ class: ["container"] }) }
      it { expect(subject.render).to eq('<span class="container">text</span>') }
    end

    context "content with block" do
      subject { ElementComponent::Element.new("div", "antes") { |e| e.add_content("depois") } }

      it { expect(subject.contents).to eq(%w[antes depois]) }
      it { expect(subject.render).to eq("<div>antesdepois</div>") }
    end

    context "nil content" do
      subject { ElementComponent::Element.new("br", nil, closing_tag: false) }

      it { expect(subject.contents).to eq([]) }
      it { expect(subject.render).to eq("<br>") }
    end
  end
end
