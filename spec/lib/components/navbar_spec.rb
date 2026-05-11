# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Navbar do
  subject { described_class.new(**options, &block) }
  let(:options) { {} }
  let(:block) { nil }

  describe "#render" do
    context "with default options" do
      it "renders navbar with expand and theme" do
        html = subject.render
        expect(html).to include("navbar")
        expect(html).to include("navbar-expand-lg")
        expect(html).to include("navbar-light")
      end

      it "includes container-fluid" do
        expect(subject.render).to include("container-fluid")
      end
    end

    context "with bg color" do
      let(:options) { { background: :primary } }

      it "adds bg class" do
        expect(subject.render).to include("bg-primary")
      end
    end

    context "with dark theme" do
      let(:options) { { theme: :dark, background: :dark } }

      it "renders dark navbar" do
        html = subject.render
        expect(html).to include("navbar-dark")
        expect(html).to include("bg-dark")
      end
    end

    context "with fixed position" do
      let(:options) { { fixed: :top } }

      it "adds fixed-top class" do
        expect(subject.render).to include("fixed-top")
      end
    end

    context "with sticky position" do
      let(:options) { { sticky: :top } }

      it "adds sticky-top class" do
        expect(subject.render).to include("sticky-top")
      end
    end

    context "without container" do
      let(:options) { { container: false } }

      it "does not include container" do
        expect(subject.render).not_to include("container-fluid")
        expect(subject.render).not_to include("<div class=\"container")
      end
    end

    context "with custom container" do
      let(:options) { { container: "container" } }

      it "uses custom container class" do
        expect(subject.render).to include('class="container"')
      end
    end

    context "with brand and nav items" do
      let(:block) do
        proc do
          add_content(ElementComponent::Components::NavbarBrand.new(href: "/") { add_content("Brand") })
          add_content(ElementComponent::Components::NavbarToggler.new(target: "navbarNav"))
          add_content(ElementComponent::Components::NavbarCollapse.new(id: "navbarNav") do
            add_content(ElementComponent::Components::NavbarNav.new do
              add_content(ElementComponent::Components::NavItem.new do
                add_content(ElementComponent::Components::NavLink.new(href: "/", active: true) { add_content("Home") })
              end)
              add_content(ElementComponent::Components::NavItem.new do
                add_content(ElementComponent::Components::NavLink.new(href: "/about") { add_content("About") })
              end)
            end)
          end)
        end
      end

      it "renders full navbar structure" do
        html = subject.render
        expect(html).to include("navbar-brand")
        expect(html).to include("navbar-toggler")
        expect(html).to include("navbar-collapse")
        expect(html).to include("navbar-nav")
        expect(html).to include("nav-item")
        expect(html).to include("nav-link")
        expect(html).to include("Brand")
        expect(html).to include("Home")
        expect(html).to include("About")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::NavbarBrand do
  subject { described_class.new(href: "/") }

  describe "#render" do
    it "renders navbar-brand link" do
      expect(subject.render).to include('<a class="navbar-brand" href="/">')
    end
  end
end

RSpec.describe ElementComponent::Components::NavbarToggler do
  subject { described_class.new(target: "navMenu") }

  describe "#render" do
    it "renders toggler button with target" do
      html = subject.render
      expect(html).to include("navbar-toggler")
      expect(html).to include('data-bs-target="#navMenu"')
      expect(html).to include("navbar-toggler-icon")
    end
  end
end

RSpec.describe ElementComponent::Components::NavbarCollapse do
  subject { described_class.new(id: "myNav") }

  describe "#render" do
    it "renders collapse navbar-collapse" do
      expect(subject.render).to include("collapse navbar-collapse")
      expect(subject.render).to include('id="myNav"')
    end
  end
end

RSpec.describe ElementComponent::Components::NavbarNav do
  subject { described_class.new }

  describe "#render" do
    it "renders navbar-nav ul" do
      expect(subject.render).to include('<ul class="navbar-nav">')
    end
  end
end
