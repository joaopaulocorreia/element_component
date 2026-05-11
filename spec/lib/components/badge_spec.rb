# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Badge do
  describe "default badge" do
    subject { ElementComponent::Components::Badge.new(variant: :primary) }

    it "has the correct element name" do
      expect(subject.element).to eq("span")
    end

    it "has badge class" do
      expect(subject.attributes[:class]).to include("badge")
    end

    it "has variant class" do
      expect(subject.attributes[:class]).to include("bg-primary")
    end

    it "renders default badge" do
      subject.add_content("New")
      expect(subject.render).to eq('<span class="badge bg-primary">New</span>')
    end
  end

  describe "pill badge" do
    it "renders pill badge" do
      badge = ElementComponent::Components::Badge.new(variant: :danger, pill: true)
      badge.add_content("99+")
      expect(badge.render).to eq('<span class="badge bg-danger rounded-pill">99+</span>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Badge.new(variant: :success) do |b|
        b.add_content("Done")
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<span class="badge bg-success">Done</span>')
    end
  end

  describe "with custom class" do
    subject do
      ElementComponent::Components::Badge.new(variant: :warning, class: "custom-badge")
    end

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom-badge")
    end
  end

  ElementComponent::Components::Badge::VALID_VARIANTS.each do |variant|
    it "renders badge-#{variant}" do
      badge = ElementComponent::Components::Badge.new(variant: variant)
      badge.add_content("Test")
      expect(badge.render).to include("bg-#{variant}")
    end
  end
end
