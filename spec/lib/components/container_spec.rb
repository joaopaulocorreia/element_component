# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Container do
  describe "default container" do
    subject { ElementComponent::Components::Container.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has container class" do
      expect(subject.attributes[:class]).to include("container")
    end

    it "renders basic container" do
      subject.add_content("content")
      expect(subject.render).to eq('<div class="container">content</div>')
    end
  end

  describe "fluid container" do
    subject { ElementComponent::Components::Container.new(fluid: true) }

    it "has container-fluid class" do
      expect(subject.attributes[:class]).to include("container-fluid")
    end

    it "renders fluid container" do
      expect(subject.render).to eq('<div class="container-fluid"></div>')
    end
  end

  describe "breakpoint container" do
    it "renders container-sm" do
      container = ElementComponent::Components::Container.new(breakpoint: :sm)
      expect(container.render).to eq('<div class="container-sm"></div>')
    end

    it "renders container-md" do
      container = ElementComponent::Components::Container.new(breakpoint: :md)
      expect(container.render).to eq('<div class="container-md"></div>')
    end

    it "renders container-lg" do
      container = ElementComponent::Components::Container.new(breakpoint: :lg)
      expect(container.render).to eq('<div class="container-lg"></div>')
    end

    it "renders container-xl" do
      container = ElementComponent::Components::Container.new(breakpoint: :xl)
      expect(container.render).to eq('<div class="container-xl"></div>')
    end

    it "renders container-xxl" do
      container = ElementComponent::Components::Container.new(breakpoint: :xxl)
      expect(container.render).to eq('<div class="container-xxl"></div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Container.new do |c|
        c << "content"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="container">content</div>')
    end
  end

  describe "with custom class" do
    subject { ElementComponent::Components::Container.new(class: "custom") }

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom")
      expect(subject.attributes[:class]).to include("container")
    end
  end
end
