# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Table do
  describe "basic table" do
    subject { ElementComponent::Components::Table.new }

    it "has the correct element name" do
      expect(subject.element).to eq("table")
    end

    it "has table class" do
      expect(subject.attributes[:class]).to include("table")
    end

    it "renders basic table" do
      expect(subject.render).to eq('<table class="table"></table>')
    end
  end

  describe "with all options" do
    it "renders with all options" do
      table = ElementComponent::Components::Table.new(
        striped: true, bordered: true, hover: true, small: true, variant: :dark
      )
      expect(table.render).to eq(
        '<table class="table table-striped table-bordered table-hover table-sm table-dark"></table>'
      )
    end
  end

  describe "with individual options" do
    it "renders striped table" do
      table = ElementComponent::Components::Table.new(striped: true)
      expect(table.render).to include("table-striped")
    end

    it "renders bordered table" do
      table = ElementComponent::Components::Table.new(bordered: true)
      expect(table.render).to include("table-bordered")
    end

    it "renders hover table" do
      table = ElementComponent::Components::Table.new(hover: true)
      expect(table.render).to include("table-hover")
    end

    it "renders small table" do
      table = ElementComponent::Components::Table.new(small: true)
      expect(table.render).to include("table-sm")
    end
  end

  describe "with block content" do
    subject do
      ElementComponent::Components::Table.new do |t|
        t.add_content("content")
      end
    end

    it "renders with content" do
      expect(subject.render).to eq('<table class="table">content</table>')
    end
  end
end
