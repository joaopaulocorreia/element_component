# frozen_string_literal: true

RSpec.describe ElementComponent::Components::BreadcrumbList do
  subject { described_class.new }

  describe "default list" do
    it "has the correct element name" do
      expect(subject.element).to eq("ol")
    end

    it "has breadcrumb class" do
      expect(subject.attributes[:class]).to include("breadcrumb")
    end

    it "renders empty list" do
      expect(subject.render).to eq('<ol class="breadcrumb"></ol>')
    end
  end

  describe "with items" do
    subject do
      described_class.new do |list|
        list << ElementComponent::Components::BreadcrumbItem.new(href: "/") { |i| i << "Home" }
        list << ElementComponent::Components::BreadcrumbItem.new(active: true) { |i| i << "Current" }
      end
    end

    it "renders list with items" do
      html = subject.render
      expect(html).to start_with('<ol class="breadcrumb">')
      expect(html).to include('<li class="breadcrumb-item"><a href="/">Home</a></li>')
      expect(html).to include('<li class="breadcrumb-item active" aria-current="page">Current</li>')
      expect(html).to end_with("</ol>")
    end
  end
end
