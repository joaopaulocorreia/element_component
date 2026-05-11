# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Nav do
  describe "basic nav" do
    subject { ElementComponent::Components::Nav.new }

    it "has the correct element name" do
      expect(subject.element).to eq("ul")
    end

    it "has nav class" do
      expect(subject.attributes[:class]).to include("nav")
    end

    it "renders basic nav" do
      expect(subject.render).to eq('<ul class="nav"></ul>')
    end
  end

  describe "tabs" do
    it "renders tabs" do
      nav = ElementComponent::Components::Nav.new(type: :tabs)
      expect(nav.render).to eq('<ul class="nav nav-tabs"></ul>')
    end
  end

  describe "pills" do
    it "renders pills" do
      nav = ElementComponent::Components::Nav.new(type: :pills)
      expect(nav.render).to eq('<ul class="nav nav-pills"></ul>')
    end
  end

  describe "underline" do
    it "renders underline" do
      nav = ElementComponent::Components::Nav.new(type: :underline)
      expect(nav.render).to eq('<ul class="nav nav-underline"></ul>')
    end
  end

  describe "fill and justified" do
    it "renders fill" do
      nav = ElementComponent::Components::Nav.new(fill: true)
      expect(nav.render).to eq('<ul class="nav nav-fill"></ul>')
    end

    it "renders justified" do
      nav = ElementComponent::Components::Nav.new(justified: true)
      expect(nav.render).to eq('<ul class="nav nav-justified"></ul>')
    end
  end

  describe "vertical" do
    it "renders vertical" do
      nav = ElementComponent::Components::Nav.new(vertical: true)
      expect(nav.render).to eq('<ul class="nav flex-column"></ul>')
    end
  end

  describe "NavItem" do
    subject { ElementComponent::Components::NavItem.new }

    it "has the correct element name" do
      expect(subject.element).to eq("li")
    end

    it "has nav-item class" do
      expect(subject.attributes[:class]).to include("nav-item")
    end
  end

  describe "NavLink" do
    describe "default link" do
      subject { ElementComponent::Components::NavLink.new }

      it "has the correct element name" do
        expect(subject.element).to eq("a")
      end

      it "has nav-link class" do
        expect(subject.attributes[:class]).to include("nav-link")
      end

      it "has default href" do
        expect(subject.attributes[:href]).to eq(["#"])
      end
    end

    describe "active link" do
      it "renders active link" do
        link = ElementComponent::Components::NavLink.new(href: "/", active: true)
        link.add_content("Home")
        expect(link.render).to include('class="nav-link active"')
        expect(link.render).to include('aria-current="page"')
      end
    end

    describe "disabled link" do
      it "renders disabled link" do
        link = ElementComponent::Components::NavLink.new(href: "/", disabled: true)
        link.add_content("Disabled")
        expect(link.render).to include("disabled")
      end
    end
  end

  describe "nav with items and links" do
    subject do
      ElementComponent::Components::Nav.new(type: :pills) do
        add_content(ElementComponent::Components::NavItem.new do
          add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
        end)
        add_content(ElementComponent::Components::NavItem.new do
          add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
        end)
      end
    end

    it "renders nav with items" do
      html = subject.render
      expect(html).to include('<ul class="nav nav-pills">')
      expect(html).to include('<li class="nav-item">')
      expect(html).to include('<a class="nav-link active" href="/" aria-current="page">Home</a>')
      expect(html).to include('<a class="nav-link" href="/about">About</a>')
    end
  end
end
