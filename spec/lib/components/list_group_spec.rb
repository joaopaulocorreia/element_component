# frozen_string_literal: true

RSpec.describe ElementComponent::Components::ListGroup do
  describe "default list group" do
    subject { ElementComponent::Components::ListGroup.new }

    it "has the correct element name" do
      expect(subject.element).to eq("ul")
    end

    it "has list-group class" do
      expect(subject.attributes[:class]).to include("list-group")
    end

    it "renders empty list group" do
      expect(subject.render).to eq('<ul class="list-group"></ul>')
    end
  end

  describe "flush list group" do
    it "renders flush list group" do
      group = ElementComponent::Components::ListGroup.new(flush: true)
      expect(group.render).to eq('<ul class="list-group list-group-flush"></ul>')
    end
  end

  describe "numbered list group" do
    it "renders numbered list group" do
      group = ElementComponent::Components::ListGroup.new(numbered: true)
      expect(group.render).to eq('<ul class="list-group list-group-numbered"></ul>')
    end
  end

  describe "ListGroupItem" do
    describe "default item" do
      subject { ElementComponent::Components::ListGroupItem.new }

      it "has the correct element name" do
        expect(subject.element).to eq("li")
      end

      it "has list-group-item class" do
        expect(subject.attributes[:class]).to include("list-group-item")
      end
    end

    describe "active item" do
      it "renders active item" do
        item = ElementComponent::Components::ListGroupItem.new(active: true)
        item.add_content("Active")
        expect(item.render).to eq('<li class="list-group-item active" aria-current="true">Active</li>')
      end
    end

    describe "item as link" do
      it "renders item as link" do
        item = ElementComponent::Components::ListGroupItem.new(href: "/page")
        item.add_content("Link")
        expect(item.render).to eq('<a class="list-group-item list-group-item-action" href="/page">Link</a>')
      end
    end

    describe "disabled item" do
      it "renders disabled item" do
        item = ElementComponent::Components::ListGroupItem.new(disabled: true)
        item.add_content("Disabled")
        expect(item.render).to include("disabled")
      end
    end

    describe "variant item" do
      it "renders variant item" do
        item = ElementComponent::Components::ListGroupItem.new(variant: :danger)
        item.add_content("Danger")
        expect(item.render).to eq('<li class="list-group-item list-group-item-danger">Danger</li>')
      end
    end
  end

  describe "list group with items" do
    subject do
      ElementComponent::Components::ListGroup.new do
        add_content(ElementComponent::Components::ListGroupItem.new { add_content("Item") })
      end
    end

    it "renders list group" do
      expect(subject.render).to eq('<ul class="list-group"><li class="list-group-item">Item</li></ul>')
    end
  end
end
