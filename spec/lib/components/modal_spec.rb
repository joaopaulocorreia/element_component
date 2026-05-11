# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Modal do
  subject { described_class.new(**options, &block) }
  let(:options) { {} }
  let(:block) { nil }

  describe "#render" do
    context "with default options" do
      it "renders a modal with fade and aria attributes" do
        html = subject.render
        expect(html).to include('<div class="modal fade" tabindex="-1" aria-hidden="true">')
        expect(html).to include("</div>")
      end

      it "includes modal-dialog" do
        expect(subject.render).to include('class="modal-dialog"')
      end
    end

    context "with static backdrop" do
      let(:options) { { static: true } }

      it "adds data attributes for static backdrop" do
        html = subject.render
        expect(html).to include('data-bs-backdrop="static"')
        expect(html).to include('data-bs-keyboard="false"')
      end
    end

    context "with scrollable and centered" do
      let(:options) { { scrollable: true, centered: true } }

      it "adds dialog modifier classes" do
        html = subject.render
        expect(html).to include("modal-dialog-scrollable")
        expect(html).to include("modal-dialog-centered")
      end
    end

    context "with size" do
      let(:options) { { size: :lg } }

      it "adds size class" do
        expect(subject.render).to include("modal-lg")
      end
    end

    context "without fade" do
      let(:options) { { fade: false } }

      it "does not add fade class" do
        expect(subject.render).not_to include("fade")
      end
    end

    context "with content block" do
      let(:options) { { size: :md } }
      let(:block) do
        proc do |m|
          m.add_content(ElementComponent::Components::ModalContent.new do |mc|
            mc.add_content(ElementComponent::Components::ModalHeader.new do |mh|
              mh.add_content(ElementComponent::Components::ModalTitle.new { |mt| mt.add_content("Title") })
            end)
            mc.add_content(ElementComponent::Components::ModalBody.new { |mb| mb.add_content("Body") })
            mc.add_content(ElementComponent::Components::ModalFooter.new { |mf| mf.add_content("Footer") })
          end)
        end
      end

      it "renders with sub-components" do
        html = subject.render
        expect(html).to include("modal-header")
        expect(html).to include("modal-title")
        expect(html).to include("modal-body")
        expect(html).to include("modal-footer")
        expect(html).to include("Title")
        expect(html).to include("Body")
        expect(html).to include("Footer")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::ModalDialog do
  subject { described_class.new(**options) }
  let(:options) { {} }

  describe "#render" do
    context "with default options" do
      it "renders modal-dialog" do
        expect(subject.render).to include('class="modal-dialog"')
      end
    end

    context "with fullscreen" do
      let(:options) { { fullscreen: :lg } }

      it "adds fullscreen class" do
        expect(subject.render).to include("modal-fullscreen-lg-down")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::ModalHeader do
  subject { described_class.new(**options) }
  let(:options) { {} }

  describe "#render" do
    context "with default options" do
      it "renders modal-header with close button" do
        html = subject.render
        expect(html).to include("modal-header")
        expect(html).to include("btn-close")
      end
    end

    context "without close button" do
      let(:options) { { close_button: false } }

      it "does not include close button" do
        expect(subject.render).not_to include("btn-close")
      end
    end
  end
end

RSpec.describe ElementComponent::Components::ModalTitle do
  subject { described_class.new }

  describe "#render" do
    it "renders modal-title h5" do
      expect(subject.render).to include('<h5 class="modal-title">')
    end
  end
end

RSpec.describe ElementComponent::Components::ModalBody do
  subject { described_class.new }

  describe "#render" do
    it "renders modal-body" do
      expect(subject.render).to include("modal-body")
    end
  end
end

RSpec.describe ElementComponent::Components::ModalFooter do
  subject { described_class.new }

  describe "#render" do
    it "renders modal-footer" do
      expect(subject.render).to include("modal-footer")
    end
  end
end

RSpec.describe ElementComponent::Components::ModalContent do
  subject { described_class.new }

  describe "#render" do
    it "renders modal-content" do
      expect(subject.render).to include("modal-content")
    end
  end
end
