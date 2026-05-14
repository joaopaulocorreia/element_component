# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Alert do
  subject { ElementComponent::Components::Alert.new }

  describe "Create alert" do
    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has role attribute" do
      expect(subject.attributes.key?(:role)).to be_truthy
      expect(subject.attributes[:role]).to eq(["alert"])
    end

    it "has default variant" do
      expect(subject.attributes[:class]).to include("alert")
      expect(subject.attributes[:class]).to include("alert-primary")
    end

    it "renders a basic alert" do
      expect(subject.render).to eq('<div class="alert alert-primary" role="alert"></div>')
    end
  end

  describe "Alert with different variants" do
    ElementComponent::Components::Alert::VALID_VARIANTS.each do |variant|
      it "renders alert-#{variant}" do
        alert = ElementComponent::Components::Alert.new(variant: variant)
        expect(alert.render).to include("alert-#{variant}")
      end
    end
  end

  describe "Alert with dismissible" do
    subject { ElementComponent::Components::Alert.new(variant: :warning, dismissible: true) }

    it "has alert-dismissible class" do
      expect(subject.attributes[:class]).to include("alert-dismissible")
    end

    it "renders a close button" do
      expect(subject.render).to include("btn-close")
      expect(subject.render).to include("data-bs-dismiss=\"alert\"")
      expect(subject.render).to include("aria-label=\"Close\"")
    end

    it "renders a complete dismissible alert" do
      expected = "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">" \
                 '<button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close"></div>'
      expect(subject.render).to eq(expected)
    end
  end

  describe "Alert with custom class" do
    subject { ElementComponent::Components::Alert.new(variant: :success, class: "custom-alert") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom-alert")
    end

    it "renders with custom class" do
      expect(subject.render).to include("custom-alert")
    end
  end

  describe "AlertHeading" do
    subject { ElementComponent::Components::AlertHeading.new }

    it "has the correct element name" do
      expect(subject.element).to eq("h4")
    end

    it "has alert-heading class" do
      expect(subject.attributes[:class]).to include("alert-heading")
    end

    it "renders a heading" do
      subject.add_content("Warning!")
      expect(subject.render).to eq('<h4 class="alert-heading">Warning!</h4>')
    end
  end

  describe "AlertLink" do
    subject { ElementComponent::Components::AlertLink.new(href: "/info") }

    it "has the correct element name" do
      expect(subject.element).to eq("a")
    end

    it "has alert-link class" do
      expect(subject.attributes[:class]).to include("alert-link")
    end

    it "has href attribute" do
      expect(subject.attributes[:href]).to eq(["/info"])
    end

    it "renders a link" do
      subject.add_content("more info")
      expected = '<a class="alert-link" href="/info">more info</a>'
      expect(subject.render).to eq(expected)
    end
  end

  describe "AlertCloseButton" do
    subject { ElementComponent::Components::AlertCloseButton.new }

    it "has the correct element name" do
      expect(subject.element).to eq("button")
    end

    it "is self-closing" do
      expect(subject.render).not_to include("</button>")
    end

    it "has btn-close class" do
      expect(subject.attributes[:class]).to include("btn-close")
    end

    it "has data-bs-dismiss attribute" do
      expect(subject.attributes[:"data-bs-dismiss"]).to eq(["alert"])
    end

    it "renders a close button" do
      expected = '<button class="btn-close" type="button" data-bs-dismiss="alert" aria-label="Close">'
      expect(subject.render).to eq(expected)
    end
  end

  describe "Alert with block content" do
    subject do
      ElementComponent::Components::Alert.new(variant: :danger) do |b|
        b << "Error occurred!"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="alert alert-danger" role="alert">Error occurred!</div>')
    end
  end

  describe "Alert with nested components" do
    subject do
      ElementComponent::Components::Alert.new(variant: :info) do |b|
        b << ElementComponent::Components::AlertHeading.new { |b2| b2 << "Info" }
        b << "Something happened. "
        b << ElementComponent::Components::AlertLink.new(href: "/details") { |b2| b2 << "View details" }
      end
    end

    it "renders alert with heading, text, and link" do
      html = subject.render
      expect(html).to start_with('<div class="alert alert-info" role="alert">')
      expect(html).to include('<h4 class="alert-heading">Info</h4>')
      expect(html).to include("Something happened. ")
      expect(html).to include('<a class="alert-link" href="/details">View details</a>')
      expect(html).to end_with("</div>")
    end
  end
end
