# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Grid do
  describe "default grid" do
    subject { ElementComponent::Components::Grid.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has grid class" do
      expect(subject.attributes[:class]).to include("grid")
    end

    it "renders basic grid" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="grid">content</div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Grid.new do |g|
        g << "content"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="grid">content</div>')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::Grid.new(class: "custom") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom")
      expect(subject.attributes[:class]).to include("grid")
    end
  end

  describe "with gap" do
    it "renders with gap" do
      grid = ElementComponent::Components::Grid.new(gap: 3)
      expect(grid.render).to eq('<div class="grid gap-3"></div>')
    end

    it "renders with row_gap" do
      grid = ElementComponent::Components::Grid.new(row_gap: 3)
      expect(grid.render).to eq('<div class="grid row-gap-3"></div>')
    end

    it "renders with column_gap" do
      grid = ElementComponent::Components::Grid.new(column_gap: 3)
      expect(grid.render).to eq('<div class="grid column-gap-3"></div>')
    end

    it "renders with multiple gap options" do
      grid = ElementComponent::Components::Grid.new(gap: 2, row_gap: 3)
      expect(grid.render).to eq('<div class="grid gap-2 row-gap-3"></div>')
    end
  end

  describe "with gap as hash" do
    it "renders with gap hash" do
      grid = ElementComponent::Components::Grid.new(gap: { default: 2, md: 3 })
      expect(grid.render).to eq('<div class="grid gap-2 gap-md-3"></div>')
    end

    it "renders with row_gap hash" do
      grid = ElementComponent::Components::Grid.new(row_gap: { default: 2, md: 3 })
      expect(grid.render).to eq('<div class="grid row-gap-2 row-gap-md-3"></div>')
    end

    it "renders with column_gap hash" do
      grid = ElementComponent::Components::Grid.new(column_gap: { default: 2, md: 3 })
      expect(grid.render).to eq('<div class="grid column-gap-2 column-gap-md-3"></div>')
    end
  end
end
