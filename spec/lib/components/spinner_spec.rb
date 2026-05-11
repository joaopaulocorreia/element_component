# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Spinner do
  describe "default border spinner" do
    subject { ElementComponent::Components::Spinner.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has spinner-border class" do
      expect(subject.attributes[:class]).to include("spinner-border")
    end

    it "has role attribute" do
      expect(subject.attributes[:role]).to eq(["status"])
    end

    it "renders border spinner" do
      expect(subject.render).to eq('<div class="spinner-border" role="status"></div>')
    end
  end

  describe "grow spinner" do
    it "renders grow spinner" do
      spinner = ElementComponent::Components::Spinner.new(type: :grow)
      expect(spinner.render).to eq('<div class="spinner-grow" role="status"></div>')
    end
  end

  describe "with variant color" do
    it "renders with variant color" do
      spinner = ElementComponent::Components::Spinner.new(variant: :primary)
      expect(spinner.render).to eq('<div class="spinner-border text-primary" role="status"></div>')
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Spinner.new do
        add_content("Loading...")
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<div class="spinner-border" role="status">Loading...</div>')
    end
  end

  describe "with custom class" do
    subject do
      ElementComponent::Components::Spinner.new(class: "custom-spinner")
    end

    it "preserves custom class" do
      expect(subject.attributes[:class]).to include("custom-spinner")
    end
  end
end
