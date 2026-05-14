# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Breadcrumb do
  describe "default breadcrumb" do
    subject { described_class.new }

    it "has the correct element name" do
      expect(subject.element).to eq("nav")
    end

    it "has aria-label attribute" do
      expect(subject.attributes[:"aria-label"]).to eq(["breadcrumb"])
    end

    it "renders empty breadcrumb" do
      expect(subject.render).to eq('<nav aria-label="breadcrumb"></nav>')
    end
  end

  describe "BreadcrumbItem" do
    describe "default item" do
      subject { ElementComponent::Components::BreadcrumbItem.new }

      it "has the correct element name" do
        expect(subject.element).to eq("li")
      end

      it "has breadcrumb-item class" do
        expect(subject.attributes[:class]).to include("breadcrumb-item")
      end
    end

    describe "active item" do
      subject { ElementComponent::Components::BreadcrumbItem.new(active: true) }

      it "has active class" do
        expect(subject.attributes[:class]).to include("active")
      end

      it "has aria-current attribute" do
        expect(subject.attributes[:"aria-current"]).to eq(["page"])
      end
    end

    describe "with href" do
      it "renders with link" do
        item = ElementComponent::Components::BreadcrumbItem.new(href: "/")
        item.add_content("Home")
        expect(item.render).to eq('<li class="breadcrumb-item"><a href="/">Home</a></li>')
      end
    end

    describe "active without href" do
      it "renders without link" do
        item = ElementComponent::Components::BreadcrumbItem.new(active: true)
        item.add_content("Current")
        expect(item.render).to eq('<li class="breadcrumb-item active" aria-current="page">Current</li>')
      end
    end
  end

  describe "breadcrumb with list and items" do
    subject do
      described_class.new do |b|
        b << ElementComponent::Components::BreadcrumbList.new do |list|
          list << ElementComponent::Components::BreadcrumbItem.new(href: "/") { |i| i << "Home" }
          list << ElementComponent::Components::BreadcrumbItem.new(active: true) { |i| i << "Current" }
        end
      end
    end

    it "renders breadcrumb with items" do
      html = subject.render
      expect(html).to start_with('<nav aria-label="breadcrumb">')
      expect(html).to include('<ol class="breadcrumb">')
      expect(html).to include('<li class="breadcrumb-item"><a href="/">Home</a></li>')
      expect(html).to include('<li class="breadcrumb-item active" aria-current="page">Current</li>')
      expect(html).to end_with("</ol></nav>")
    end
  end
end
