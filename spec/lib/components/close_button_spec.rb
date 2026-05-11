# frozen_string_literal: true

RSpec.describe ElementComponent::Components::CloseButton do
  describe "default close button" do
    subject { ElementComponent::Components::CloseButton.new }

    it "has the correct element name" do
      expect(subject.element).to eq("button")
    end

    it "is self-closing" do
      expect(subject.render).not_to include("</button>")
    end

    it "has btn-close class" do
      expect(subject.attributes[:class]).to include("btn-close")
    end

    it "has type attribute" do
      expect(subject.attributes[:type]).to eq(["button"])
    end

    it "has aria-label attribute" do
      expect(subject.attributes[:"aria-label"]).to eq(["Close"])
    end

    it "renders close button" do
      expect(subject.render).to eq('<button class="btn-close" type="button" aria-label="Close">')
    end
  end

  describe "disabled close button" do
    subject { ElementComponent::Components::CloseButton.new(disabled: true) }

    it "has disabled attribute" do
      expect(subject.attributes.key?(:disabled)).to be_truthy
    end

    it "renders disabled" do
      expect(subject.render).to include('disabled=""')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::CloseButton.new(class: "custom-close") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom-close")
    end
  end
end
