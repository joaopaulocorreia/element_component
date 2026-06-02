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

  describe "with size" do
    it "renders col-6" do
      col = ElementComponent::Components::Col.new(size: 6)
      expect(col.render).to eq('<div class="col-6"></div>')
    end

    it "renders col-12" do
      col = ElementComponent::Components::Col.new(size: 12)
      expect(col.render).to eq('<div class="col-12"></div>')
    end
  end

  describe "with breakpoint" do
    it "renders col-md" do
      col = ElementComponent::Components::Col.new(breakpoint: :md)
      expect(col.render).to eq('<div class="col-md"></div>')
    end

    it "renders col-md-6" do
      col = ElementComponent::Components::Col.new(breakpoint: :md, size: 6)
      expect(col.render).to eq('<div class="col-md-6"></div>')
    end

    it "renders col-lg-4" do
      col = ElementComponent::Components::Col.new(breakpoint: :lg, size: 4)
      expect(col.render).to eq('<div class="col-lg-4"></div>')
    end

    it "renders col-sm-12" do
      col = ElementComponent::Components::Col.new(breakpoint: :sm, size: 12)
      expect(col.render).to eq('<div class="col-sm-12"></div>')
    end
  end

  describe "with offset" do
    it "renders with offset" do
      col = ElementComponent::Components::Col.new(size: 6, offset: 3)
      expect(col.render).to eq('<div class="col-6 offset-3"></div>')
    end
  end

  describe "with order" do
    it "renders with order" do
      col = ElementComponent::Components::Col.new(size: 6, order: 1)
      expect(col.render).to eq('<div class="col-6 order-1"></div>')
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

  describe "with multiple breakpoints" do
    it "renders col-12 col-lg-6" do
      col = ElementComponent::Components::Col.new(breakpoints: { nil => 12, lg: 6 })
      expect(col.render).to eq('<div class="col-12 col-lg-6"></div>')
    end

    it "renders col-12 col-lg-12 col-md-3" do
      col = ElementComponent::Components::Col.new(breakpoints: { nil => 12, lg: 12, md: 3 })
      expect(col.render).to eq('<div class="col-12 col-lg-12 col-md-3"></div>')
    end

    it "renders col-sm-6 col-md-4 col-lg-3" do
      col = ElementComponent::Components::Col.new(breakpoints: { sm: 6, md: 4, lg: 3 })
      expect(col.render).to eq('<div class="col-sm-6 col-md-4 col-lg-3"></div>')
    end

    it "renders col-md col-lg" do
      col = ElementComponent::Components::Col.new(breakpoints: { md: nil, lg: nil })
      expect(col.render).to eq('<div class="col-md col-lg"></div>')
    end
  end

  describe "with multiple offsets" do
    it "renders with multiple offsets" do
      col = ElementComponent::Components::Col.new(size: 6, offsets: { nil => 3, md: 2 })
      expect(col.render).to eq('<div class="col-6 offset-3 offset-md-2"></div>')
    end
  end

  describe "with multiple orders" do
    it "renders with multiple orders" do
      col = ElementComponent::Components::Col.new(size: 6, orders: { nil => 1, md: 2 })
      expect(col.render).to eq('<div class="col-6 order-1 order-md-2"></div>')
    end
  end
end
