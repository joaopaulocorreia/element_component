# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Col do
  describe "default col" do
    subject { ElementComponent::Components::Col.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has col class" do
      expect(subject.attributes[:class]).to include("col")
    end

    it "renders basic col" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="col">content</div>')
    end
  end

  describe "with col" do
    it "renders col-6" do
      col = ElementComponent::Components::Col.new(col: 6)
      expect(col.render).to eq('<div class="col-6"></div>')
    end

    it "renders col-12" do
      col = ElementComponent::Components::Col.new(col: 12)
      expect(col.render).to eq('<div class="col-12"></div>')
    end
  end

  describe "with col as hash" do
    it "renders col-md-6" do
      col = ElementComponent::Components::Col.new(col: { md: 6 })
      expect(col.render).to eq('<div class="col-md-6"></div>')
    end

    it "renders col-lg-4" do
      col = ElementComponent::Components::Col.new(col: { lg: 4 })
      expect(col.render).to eq('<div class="col-lg-4"></div>')
    end

    it "renders col-12 col-md-6" do
      col = ElementComponent::Components::Col.new(col: { default: 12, md: 6 })
      expect(col.render).to eq('<div class="col-12 col-md-6"></div>')
    end

    it "renders col-12 col-md-6 col-lg-4" do
      col = ElementComponent::Components::Col.new(col: { default: 12, md: 6, lg: 4 })
      expect(col.render).to eq('<div class="col-12 col-md-6 col-lg-4"></div>')
    end

    it "renders col-md col-lg (auto width)" do
      col = ElementComponent::Components::Col.new(col: { md: true, lg: true })
      expect(col.render).to eq('<div class="col-md col-lg"></div>')
    end

    it "renders col col-md-6" do
      col = ElementComponent::Components::Col.new(col: { default: true, md: 6 })
      expect(col.render).to eq('<div class="col col-md-6"></div>')
    end
  end

  describe "with offset" do
    it "renders with offset" do
      col = ElementComponent::Components::Col.new(col: 6, offset: 3)
      expect(col.render).to eq('<div class="col-6 offset-3"></div>')
    end
  end

  describe "with offset as hash" do
    it "renders with offset hash" do
      col = ElementComponent::Components::Col.new(col: 6, offset: { default: 3, md: 2 })
      expect(col.render).to eq('<div class="col-6 offset-3 offset-md-2"></div>')
    end

    it "renders with offset hash without default" do
      col = ElementComponent::Components::Col.new(col: 6, offset: { md: 2, lg: 1 })
      expect(col.render).to eq('<div class="col-6 offset-md-2 offset-lg-1"></div>')
    end
  end

  describe "with order" do
    it "renders with order" do
      col = ElementComponent::Components::Col.new(col: 6, order: 1)
      expect(col.render).to eq('<div class="col-6 order-1"></div>')
    end
  end

  describe "with order as hash" do
    it "renders with order hash" do
      col = ElementComponent::Components::Col.new(col: 6, order: { default: 1, md: 2 })
      expect(col.render).to eq('<div class="col-6 order-1 order-md-2"></div>')
    end

    it "renders with order hash without default" do
      col = ElementComponent::Components::Col.new(col: 6, order: { md: 2, lg: 3 })
      expect(col.render).to eq('<div class="col-6 order-md-2 order-lg-3"></div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Col.new do |c|
        c << "content"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="col">content</div>')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::Col.new(class: "custom") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom")
      expect(subject.attributes[:class]).to include("col")
    end
  end
end
