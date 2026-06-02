# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Row do
  describe "default row" do
    subject { ElementComponent::Components::Row.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has row class" do
      expect(subject.attributes[:class]).to include("row")
    end

    it "renders basic row" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="row">content</div>')
    end
  end

  describe "with cols" do
    it "renders row-cols-2" do
      row = ElementComponent::Components::Row.new(cols: 2)
      expect(row.render).to eq('<div class="row row-cols-2"></div>')
    end

    it "renders row-cols-3" do
      row = ElementComponent::Components::Row.new(cols: 3)
      expect(row.render).to eq('<div class="row row-cols-3"></div>')
    end
  end

  describe "with gutters" do
    it "renders with gutter" do
      row = ElementComponent::Components::Row.new(gutter: 3)
      expect(row.render).to eq('<div class="row g-3"></div>')
    end

    it "renders with gutter_x" do
      row = ElementComponent::Components::Row.new(gutter_x: 2)
      expect(row.render).to eq('<div class="row gx-2"></div>')
    end

    it "renders with gutter_y" do
      row = ElementComponent::Components::Row.new(gutter_y: 4)
      expect(row.render).to eq('<div class="row gy-4"></div>')
    end

    it "renders with both gutter_x and gutter_y" do
      row = ElementComponent::Components::Row.new(gutter_x: 2, gutter_y: 3)
      expect(row.render).to eq('<div class="row gx-2 gy-3"></div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Row.new do |r|
        r << "content"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="row">content</div>')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::Row.new(class: "custom") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom")
      expect(subject.attributes[:class]).to include("row")
    end
  end
end
