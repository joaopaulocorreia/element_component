# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Button do
  describe "default button" do
    subject { ElementComponent::Components::Button.new(variant: :primary) }

    it "has the correct element name" do
      expect(subject.element).to eq("button")
    end

    it "has type attribute" do
      expect(subject.attributes[:type]).to eq(["button"])
    end

    it "has btn class" do
      expect(subject.attributes[:class]).to include("btn")
    end

    it "renders default button" do
      subject.add_content("Click")
      expect(subject.render).to eq('<button type="button" class="btn btn-primary">Click</button>')
    end
  end

  describe "outline button" do
    it "renders outline button" do
      btn = ElementComponent::Components::Button.new(variant: :danger, outline: true)
      btn.add_content("Delete")
      expect(btn.render).to eq('<button type="button" class="btn btn-outline-danger">Delete</button>')
    end
  end

  describe "size variant" do
    it "renders size variant" do
      btn = ElementComponent::Components::Button.new(variant: :success, size: :lg)
      btn.add_content("Big")
      expect(btn.render).to eq('<button type="button" class="btn btn-success btn-lg">Big</button>')
    end

    it "renders small button" do
      btn = ElementComponent::Components::Button.new(variant: :primary, size: :sm)
      btn.add_content("Small")
      expect(btn.render).to eq('<button type="button" class="btn btn-primary btn-sm">Small</button>')
    end
  end

  describe "as link" do
    it "renders as link when href given" do
      btn = ElementComponent::Components::Button.new(variant: :primary, href: "/")
      btn.add_content("Home")
      html = btn.render
      expect(btn.element).to eq("a")
      expect(html).to include('href="/"')
      expect(html).to include('class="btn btn-primary"')
      expect(html).to include(">Home</a>")
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Button.new(variant: :info) do |b|
        b << "Info"
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<button type="button" class="btn btn-info">Info</button>')
    end
  end

  describe "with custom attributes" do
    subject do
      ElementComponent::Components::Button.new(variant: :secondary, id: "btn-1", data: { action: "submit" })
    end

    it "preserves custom attributes" do
      expect(subject.attributes[:id]).to eq(["btn-1"])
    end
  end

  ElementComponent::Components::Button::VALID_VARIANTS.each do |variant|
    it "renders button btn-#{variant}" do
      btn = ElementComponent::Components::Button.new(variant: variant)
      btn.add_content("Test")
      expect(btn.render).to include("btn-#{variant}")
    end
  end
end
