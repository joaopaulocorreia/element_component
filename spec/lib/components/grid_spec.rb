# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Grid do
  describe "default grid" do
    subject { ElementComponent::Components::Grid.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has container class" do
      expect(subject.attributes[:class]).to include("container")
    end

    it "renders basic grid" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="container">content</div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Grid.new do |g|
        g << "content"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="container">content</div>')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::Grid.new(class: "custom") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom")
      expect(subject.attributes[:class]).to include("container")
    end
  end
end
