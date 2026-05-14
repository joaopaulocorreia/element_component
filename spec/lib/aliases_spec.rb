# frozen_string_literal: true

RSpec.describe "ElementComponent aliases" do
  describe "E alias" do
    it "creates an element" do
      element = ElementComponent::E.new("div", "content")
      expect(element.render).to eq("<div>content</div>")
    end

    it "creates an element with attributes" do
      element = ElementComponent::E.new("span", "text", class: "highlight")
      expect(element.render).to eq('<span class="highlight">text</span>')
    end
  end

  describe "global E alias" do
    it "creates an element at global scope" do
      element = E.new("div", "content")
      expect(element.render).to eq("<div>content</div>")
    end

    it "creates an element with attributes at global scope" do
      element = E.new("span", "text", class: "highlight")
      expect(element.render).to eq('<span class="highlight">text</span>')
    end
  end

  describe "tag helper" do
    it "creates an element" do
      element = ElementComponent.tag("div", "content")
      expect(element.render).to eq("<div>content</div>")
    end

    it "creates an element with attributes" do
      element = ElementComponent.tag("span", "text", class: "highlight")
      expect(element.render).to eq('<span class="highlight">text</span>')
    end

    it "creates an element with block" do
      element = ElementComponent.tag("div") { |b| b << "block" }
      expect(element.render).to eq("<div>block</div>")
    end

    it "creates an element with content and block" do
      element = ElementComponent.tag("div", "before") { |b| b << "after" }
      expect(element.render).to eq("<div>beforeafter</div>")
    end
  end

  describe "EC alias" do
    it "creates a Card" do
      card = ElementComponent::EC::Card.new("content")
      expect(card.render).to eq('<div class="card">content</div>')
    end

    it "creates a Button" do
      button = ElementComponent::EC::Button.new("Click", variant: :primary)
      expect(button.render).to eq('<button type="button" class="btn btn-primary">Click</button>')
    end
  end

  describe "global EC alias" do
    it "creates a Card at global scope" do
      card = EC::Card.new("content")
      expect(card.render).to eq('<div class="card">content</div>')
    end

    it "creates a Button at global scope" do
      button = EC::Button.new("Click", variant: :primary)
      expect(button.render).to eq('<button type="button" class="btn btn-primary">Click</button>')
    end

    it "creates an Alert at global scope" do
      alert = EC::Alert.new("message", variant: :success)
      expect(alert.render).to include("alert-success")
    end

    it "creates a Spinner at global scope" do
      spinner = EC::Spinner.new
      expect(spinner.render).to eq('<div class="spinner-border" role="status"></div>')
    end
  end

  describe "component aliases" do
    it "creates Card directly" do
      card = ElementComponent::Card.new("content")
      expect(card.render).to eq('<div class="card">content</div>')
    end

    it "creates Alert directly" do
      alert = ElementComponent::Alert.new("message", variant: :success)
      expect(alert.render).to eq('<div class="alert alert-success" role="alert">message</div>')
    end

    it "creates Button directly" do
      button = ElementComponent::Button.new("Click", variant: :primary)
      expect(button.render).to eq('<button type="button" class="btn btn-primary">Click</button>')
    end

    it "creates CardHeader directly" do
      header = ElementComponent::CardHeader.new("Header")
      expect(header.render).to eq('<div class="card-header">Header</div>')
    end

    it "creates Badge directly" do
      badge = ElementComponent::Badge.new("New", variant: :primary)
      expect(badge.render).to eq('<span class="badge bg-primary">New</span>')
    end

    it "creates Spinner directly" do
      spinner = ElementComponent::Spinner.new
      expect(spinner.render).to eq('<div class="spinner-border" role="status"></div>')
    end

    it "creates Table directly" do
      table = ElementComponent::Table.new("content")
      expect(table.render).to eq('<table class="table">content</table>')
    end

    it "creates Modal directly" do
      modal = ElementComponent::Modal.new
      expect(modal.render).to include("modal")
      expect(modal.render).to include("modal-dialog")
    end

    it "creates NavItem directly" do
      item = ElementComponent::NavItem.new("item")
      expect(item.render).to eq('<li class="nav-item">item</li>')
    end

    it "creates NavLink directly" do
      link = ElementComponent::NavLink.new("Home", href: "/")
      expect(link.render).to eq('<a class="nav-link" href="/">Home</a>')
    end
  end

  describe "Shortcuts module" do
    let(:helper_class) do
      Class.new do
        include ElementComponent::Shortcuts
      end
    end

    it "creates Card via shortcut" do
      helper = helper_class.new
      card = helper.Card("content")
      expect(card.render).to eq('<div class="card">content</div>')
    end

    it "creates E via shortcut" do
      helper = helper_class.new
      element = helper.E("div", "text")
      expect(element.render).to eq("<div>text</div>")
    end

    it "creates element via element_tag shortcut" do
      helper = helper_class.new
      element = helper.element_tag("span", "text")
      expect(element.render).to eq("<span>text</span>")
    end

    it "creates Alert via shortcut" do
      helper = helper_class.new
      alert = helper.Alert("message", variant: :danger)
      expect(alert.render).to include("alert-danger")
    end

    it "creates Button via shortcut" do
      helper = helper_class.new
      button = helper.Button("Click", variant: :primary)
      expect(button.render).to include("btn-primary")
    end

    it "creates CardHeader via shortcut" do
      helper = helper_class.new
      header = helper.CardHeader("Header")
      expect(header.render).to eq('<div class="card-header">Header</div>')
    end
  end
end
