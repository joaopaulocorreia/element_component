# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Carousel do
  subject { described_class.new(**options, &block) }
  let(:options) { {} }
  let(:block) { nil }

  describe "#render" do
    context "with default options" do
      it "renders carousel with slide class" do
        expect(subject.render).to include('<div id="carousel" class="carousel slide"')
      end

      it "includes indicators" do
        expect(subject.render).to include("carousel-indicators")
      end

      it "includes controls" do
        expect(subject.render).to include("carousel-control-prev")
        expect(subject.render).to include("carousel-control-next")
      end

      it "includes carousel-inner" do
        expect(subject.render).to include("carousel-inner")
      end
    end

    context "with fade effect" do
      let(:options) { { fade: true } }

      it "adds carousel-fade class" do
        expect(subject.render).to include("carousel-fade")
      end
    end

    context "without indicators" do
      let(:options) { { indicators: false } }

      it "does not render indicators" do
        expect(subject.render).not_to include("carousel-indicators")
      end
    end

    context "without controls" do
      let(:options) { { controls: false } }

      it "does not render controls" do
        expect(subject.render).not_to include("carousel-control-prev")
      end
    end

    context "with custom id" do
      let(:options) { { id: "my-carousel" } }

      it "uses custom id for controls target" do
        html = subject.render
        expect(html).to include('id="my-carousel"')
        expect(html).to include('data-bs-target="#my-carousel"')
      end
    end

    context "with items" do
      let(:block) do
        proc do |b|
          b << ElementComponent::Components::CarouselItem.new(active: true) do |b2|
            b2 << ElementComponent::Components::CarouselCaption.new { |b3| b3 << "Caption 1" }
          end
          b << ElementComponent::Components::CarouselItem.new do |b2|
            b2 << ElementComponent::Components::CarouselCaption.new { |b3| b3 << "Caption 2" }
          end
        end
      end

      it "renders items inside carousel-inner" do
        html = subject.render
        expect(html).to include("carousel-item")
        expect(html).to include("active")
        expect(html).to include("carousel-caption")
        expect(html).to include("Caption 1")
        expect(html).to include("Caption 2")
      end

      it "generates indicators for each item" do
        html = subject.render
        expect(html.scan('data-bs-slide-to="').length).to eq(2)
      end
    end
  end
end

RSpec.describe ElementComponent::Components::CarouselItem do
  subject { described_class.new(**options) }
  let(:options) { {} }

  describe "#render" do
    context "with default options" do
      it "renders carousel-item" do
        expect(subject.render).to include("carousel-item")
      end
    end

    context "with active" do
      let(:options) { { active: true } }

      it "adds active class" do
        expect(subject.render).to include("carousel-item active")
      end
    end

    context "with custom interval" do
      let(:options) { { interval: 2000 } }

      it "adds data-bs-interval" do
        expect(subject.render).to include('data-bs-interval="2000"')
      end
    end
  end
end

RSpec.describe ElementComponent::Components::CarouselCaption do
  subject { described_class.new }

  describe "#render" do
    it "renders carousel-caption" do
      expect(subject.render).to include("carousel-caption")
    end
  end
end
