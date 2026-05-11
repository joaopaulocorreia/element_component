# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Card do
  describe "basic card" do
    subject { ElementComponent::Components::Card.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has card class" do
      expect(subject.attributes[:class]).to include("card")
    end

    it "renders basic card" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="card">content</div>')
    end
  end

  describe "CardHeader" do
    subject { ElementComponent::Components::CardHeader.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has card-header class" do
      expect(subject.attributes[:class]).to include("card-header")
    end

    it "renders a header" do
      subject.add_content("Header")
      expect(subject.render).to eq('<div class="card-header">Header</div>')
    end
  end

  describe "CardBody" do
    subject { ElementComponent::Components::CardBody.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has card-body class" do
      expect(subject.attributes[:class]).to include("card-body")
    end

    it "renders a body" do
      subject.add_content("Body")
      expect(subject.render).to eq('<div class="card-body">Body</div>')
    end
  end

  describe "CardFooter" do
    subject { ElementComponent::Components::CardFooter.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has card-footer class" do
      expect(subject.attributes[:class]).to include("card-footer")
    end

    it "renders a footer" do
      subject.add_content("Footer")
      expect(subject.render).to eq('<div class="card-footer">Footer</div>')
    end
  end

  describe "CardTitle" do
    subject { ElementComponent::Components::CardTitle.new }

    it "has the correct element name" do
      expect(subject.element).to eq("h5")
    end

    it "has card-title class" do
      expect(subject.attributes[:class]).to include("card-title")
    end

    it "renders a title" do
      subject.add_content("Title")
      expect(subject.render).to eq('<h5 class="card-title">Title</h5>')
    end
  end

  describe "CardText" do
    subject { ElementComponent::Components::CardText.new }

    it "has the correct element name" do
      expect(subject.element).to eq("p")
    end

    it "has card-text class" do
      expect(subject.attributes[:class]).to include("card-text")
    end

    it "renders text" do
      subject.add_content("Some text")
      expect(subject.render).to eq('<p class="card-text">Some text</p>')
    end
  end

  describe "CardImage" do
    it "renders image" do
      img = ElementComponent::Components::CardImage.new(src: "img.jpg")
      expect(img.render).to include('<img class="card-img" src="img.jpg"')
    end

    it "renders image top" do
      img = ElementComponent::Components::CardImage.new(src: "img.jpg", top: true)
      expect(img.render).to include("card-img-top")
    end

    it "renders image bottom" do
      img = ElementComponent::Components::CardImage.new(src: "img.jpg", bottom: true)
      expect(img.render).to include("card-img-bottom")
    end

    it "is self-closing" do
      img = ElementComponent::Components::CardImage.new(src: "img.jpg")
      expect(img.render).not_to include("</img>")
    end
  end

  describe "card with header, body, footer" do
    subject do
      ElementComponent::Components::Card.new do
        add_content(ElementComponent::Components::CardHeader.new { add_content("Header") })
        add_content(ElementComponent::Components::CardBody.new { add_content("Body") })
        add_content(ElementComponent::Components::CardFooter.new { add_content("Footer") })
      end
    end

    it "renders full card" do
      html = subject.render
      expect(html).to include('<div class="card-header">Header</div>')
      expect(html).to include('<div class="card-body">Body</div>')
      expect(html).to include('<div class="card-footer">Footer</div>')
    end
  end

  describe "card with title and text" do
    subject do
      ElementComponent::Components::Card.new do
        add_content(ElementComponent::Components::CardBody.new do
          add_content(ElementComponent::Components::CardTitle.new { add_content("Title") })
          add_content(ElementComponent::Components::CardText.new { add_content("Text") })
        end)
      end
    end

    it "renders card with title and text" do
      html = subject.render
      expect(html).to include('<h5 class="card-title">Title</h5>')
      expect(html).to include('<p class="card-text">Text</p>')
    end
  end

  describe "card with image" do
    subject do
      ElementComponent::Components::Card.new do
        add_content(ElementComponent::Components::CardImage.new(src: "img.jpg", top: true))
      end
    end

    it "renders card with image" do
      expect(subject.render).to include('<img class="card-img card-img-top" src="img.jpg"')
    end
  end
end
