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

    context "with menu and items" do
      let(:block) do
        proc do |e|
          e.add_content(ElementComponent::Components::DropdownMenu.new do |menu|
            menu.add_content(ElementComponent::Components::DropdownItem.new { |item| item.add_content("Action") })
            menu.add_content(ElementComponent::Components::DropdownItem.new(active: true) do |item|
              item.add_content("Active")
            end)
            menu.add_content(ElementComponent::Components::DropdownDivider.new)
            menu.add_content(ElementComponent::Components::DropdownHeader.new do |header|
              header.add_content("Section")
            end)
            menu.add_content(ElementComponent::Components::DropdownItem.new(disabled: true) do |item|
              item.add_content("Disabled")
            end)
          end)
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
  let(:block) { proc { |d| d.add_content("Item") } }

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
