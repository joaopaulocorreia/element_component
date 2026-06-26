# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Dropdown do
  subject { described_class.new(**options, &block) }
  let(:options) { {} }
  let(:block) { nil }

  describe "#render" do
    context "with default options" do
      it "renders dropdown container" do
        expect(subject.render).to include('class="dropdown"')
      end
    end

    context "with direction" do
      let(:options) { { direction: :dropend } }

      it "adds direction class" do
        expect(subject.render).to include("dropend")
      end
    end

    context "with an invalid direction" do
      let(:options) { { direction: :sideways } }

      it "raises ArgumentError" do
        expect { subject }.to raise_error(ArgumentError, /Invalid direction/)
      end
    end

    context "with content and attributes" do
      let(:options) { { id: "menu-1" } }

      it "forwards content and attributes to the element" do
        dropdown = described_class.new("Label", id: "menu-1")
        html = dropdown.render
        expect(html).to include('id="menu-1"')
        expect(html).to include("Label")
      end
    end

    context "with a toggle button" do
      it "renders a standard toggle button" do
        html = described_class.new.toggle_button(label: "Menu", variant: :primary).render
        expect(html).to include("dropdown-toggle")
        expect(html).to include("btn-primary")
        expect(html).to include('data-bs-toggle="dropdown"')
        expect(html).to include("Menu")
      end

      it "renders a split toggle button" do
        html = described_class.new.toggle_button(label: "Menu", split: true).render
        expect(html).to include("dropdown-toggle-split")
        expect(html).to include("visually-hidden")
        expect(html).to include("btn-group")
      end
    end

    context "with menu and items" do
      let(:block) do
        proc do |b|
          b << ElementComponent::Components::DropdownMenu.new do |menu|
            menu << ElementComponent::Components::DropdownItem.new { |b2| b2 << "Action" }
            menu << ElementComponent::Components::DropdownItem.new(active: true) do |item|
              item << "Active"
            end
            menu << ElementComponent::Components::DropdownDivider.new
            menu << ElementComponent::Components::DropdownHeader.new do |header|
              header << "Section"
            end
            menu << ElementComponent::Components::DropdownItem.new(disabled: true) do |item|
              item << "Disabled"
            end
          end
        end
      end

      it "renders menu with items" do
        html = subject.render
        expect(html).to include("dropdown-menu")
        expect(html).to include("dropdown-item")
        expect(html).to include("dropdown-divider")
        expect(html).to include("dropdown-header")
        expect(html).to include("Action")
        expect(html).to include("Active")
        expect(html).to include("Disabled")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::DropdownMenu do
  subject { described_class.new(**options) }
  let(:options) { {} }

  describe "#render" do
    context "with default options" do
      it "renders dropdown-menu ul" do
        expect(subject.render).to include('<ul class="dropdown-menu">')
      end
    end

    context "with alignment" do
      let(:options) { { align: :end } }

      it "adds alignment class" do
        expect(subject.render).to include("dropdown-menu-end")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::DropdownItem do
  subject { described_class.new(**options, &block) }
  let(:options) { {} }
  let(:block) { proc { |b| b << "Item" } }

  describe "#render" do
    context "with default options" do
      it "renders a link dropdown-item" do
        html = subject.render
        expect(html).to include("dropdown-item")
        expect(html).to include('href="#"')
      end
    end

    context "as button type" do
      let(:options) { { type: :button } }

      it "renders a button" do
        expect(subject.render).to include('type="button"')
      end
    end

    context "with active state" do
      let(:options) { { active: true } }

      it "adds active class" do
        expect(subject.render).to include("active")
      end
    end

    context "with disabled state" do
      let(:options) { { disabled: true } }

      it "adds disabled class and attributes" do
        html = subject.render
        expect(html).to include("disabled")
        expect(html).to include('tabindex="-1"')
        expect(html).to include('aria-disabled="true"')
      end
    end
  end
end

RSpec.describe ElementComponent::Components::DropdownDivider do
  subject { described_class.new }

  describe "#render" do
    it "renders a divider" do
      expect(subject.render).to include("dropdown-divider")
    end
  end
end

RSpec.describe ElementComponent::Components::DropdownHeader do
  subject { described_class.new }

  describe "#render" do
    it "renders dropdown-header h6" do
      expect(subject.render).to include("dropdown-header")
    end
  end
end
