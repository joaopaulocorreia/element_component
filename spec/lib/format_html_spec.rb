# frozen_string_literal: true

RSpec.describe ElementComponent do
  describe ".format_html" do
    it "formats nested elements" do
      html = %(<div class="card"><div class="header">Title</div></div>)
      expected = <<~HTML.strip
        <div class="card">
          <div class="header">Title</div>
        </div>
      HTML
      expect(described_class.format_html(html)).to eq(expected)
    end

    it "handles deep nesting" do
      html = "<div><div><div><p>deep</p></div></div></div>"
      expected = <<~HTML.strip
        <div>
          <div>
            <div>
              <p>deep</p>
            </div>
          </div>
        </div>
      HTML
      expect(described_class.format_html(html)).to eq(expected)
    end

    it "preserves void elements" do
      html = "<div><br><img src=\"a.png\"><hr></div>"
      result = described_class.format_html(html)
      expect(result).to include("<br>")
      expect(result).to include("<img src=\"a.png\">")
      expect(result).to include("<hr>")
    end

    it "handles custom indent size" do
      html = "<div><p>text</p></div>"
      expected = <<~HTML.strip
        <div>
            <p>text</p>
        </div>
      HTML
      expect(described_class.format_html(html, indent: 4)).to eq(expected)
    end

    it "returns empty string for nil" do
      expect(described_class.format_html(nil)).to eq("")
    end

    it "returns empty string for empty string" do
      expect(described_class.format_html("")).to eq("")
    end

    it "handles plain text without tags" do
      expect(described_class.format_html("just text")).to eq("just text")
    end

    it "handles tags with multiple attributes" do
      html = %(<a href="/" class="nav-link" id="home">Home</a>)
      expected = <<~HTML.strip
        <a href="/" class="nav-link" id="home">Home</a>
      HTML
      expect(described_class.format_html(html)).to eq(expected)
    end

    it "formats a real card component output" do
      card = ElementComponent::Components::Card.new
      card.add_content(ElementComponent::Components::CardHeader.new.tap { |h| h.add_content("Header") })
      body = ElementComponent::Components::CardBody.new
      body.add_content(ElementComponent::Components::CardTitle.new.tap { |t| t.add_content("Title") })
      card.add_content(body)

      expected = <<~HTML.strip
        <div class="card">
          <div class="card-header">Header</div>
          <div class="card-body">
            <h5 class="card-title">Title</h5>
          </div>
        </div>
      HTML
      expect(described_class.format_html(card.render)).to eq(expected)
    end
  end

  describe ".format_html via Element#format_html" do
    it "formats element render output" do
      el = ElementComponent::Element.new("div")
      el.add_content("hello")
      expect(el.format_html).to eq("<div>hello</div>")
    end

    it "formats nested element render output" do
      el = ElementComponent::Element.new("div")
      el.add_content(ElementComponent::Element.new("p").tap { |s| s.add_content("hi") })
      expected = <<~HTML.strip
        <div>
          <p>hi</p>
        </div>
      HTML
      expect(el.format_html).to eq(expected)
    end

    it "respects closing_tag: false" do
      img = ElementComponent::Element.new("img", closing_tag: false, src: "a.png")
      expect(img.format_html).to eq(%(<img src="a.png">))
    end

    it "accepts custom indent" do
      el = ElementComponent::Element.new("div")
      child = ElementComponent::Element.new("p")
      child.add_content("text")
      el.add_content(child)
      expected = "<div>\n    <p>text</p>\n</div>"
      expect(el.format_html(indent: 4)).to eq(expected)
    end
  end
end
