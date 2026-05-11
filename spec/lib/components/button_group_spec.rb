# frozen_string_literal: true

RSpec.describe ElementComponent::Components::ButtonGroup do
  describe "default button group" do
    subject { ElementComponent::Components::ButtonGroup.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has btn-group class" do
      expect(subject.attributes[:class]).to include("btn-group")
    end

    it "has role attribute" do
      expect(subject.attributes[:role]).to eq(["group"])
    end

    it "renders button group" do
      expect(subject.render).to eq('<div class="btn-group" role="group"></div>')
    end
  end

  describe "vertical group" do
    it "renders vertical group" do
      group = ElementComponent::Components::ButtonGroup.new(vertical: true)
      expect(group.render).to eq('<div class="btn-group-vertical" role="group"></div>')
    end
  end

  describe "with size" do
    it "renders with size" do
      group = ElementComponent::Components::ButtonGroup.new(size: :sm)
      expect(group.render).to eq('<div class="btn-group btn-group-sm" role="group"></div>')
    end

    it "renders with lg size" do
      group = ElementComponent::Components::ButtonGroup.new(size: :lg)
      expect(group.render).to eq('<div class="btn-group btn-group-lg" role="group"></div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::ButtonGroup.new do
        add_content("content")
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="btn-group" role="group">content</div>')
    end
  end

  describe "with custom class" do
    subject do
      ElementComponent::Components::ButtonGroup.new(class: "custom-group")
    end

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom-group")
    end
  end
end
