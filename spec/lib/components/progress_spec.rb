# frozen_string_literal: true

RSpec.describe ElementComponent::Components::Progress do
  describe "default progress" do
    subject { ElementComponent::Components::Progress.new }

    it "has the correct element name" do
      expect(subject.element).to eq("div")
    end

    it "has progress class" do
      expect(subject.attributes[:class]).to include("progress")
    end

    it "has role attribute" do
      expect(subject.attributes[:role]).to eq(["progressbar"])
    end

    it "renders empty progress" do
      expect(subject.render).to eq('<div class="progress" role="progressbar"></div>')
    end
  end

  describe "ProgressBar" do
    describe "default bar" do
      subject { ElementComponent::Components::ProgressBar.new(value: 50) }

      it "has the correct element name" do
        expect(subject.element).to eq("div")
      end

      it "has progress-bar class" do
        expect(subject.attributes[:class]).to include("progress-bar")
      end

      it "has aria-valuenow attribute" do
        expect(subject.attributes[:"aria-valuenow"]).to eq(["50"])
      end

      it "has style attribute" do
        expect(subject.attributes[:style]).to eq(["width: 50%"])
      end
    end

    describe "with variant" do
      it "renders with variant color" do
        bar = ElementComponent::Components::ProgressBar.new(value: 75, variant: :success)
        expect(bar.render).to include("bg-success")
      end
    end

    describe "striped and animated" do
      it "renders striped animated bar" do
        bar = ElementComponent::Components::ProgressBar.new(value: 50, striped: true, animated: true)
        expect(bar.render).to include("progress-bar-striped progress-bar-animated")
      end
    end
  end

  describe "progress with bar" do
    subject do
      ElementComponent::Components::Progress.new do |b|
        b << ElementComponent::Components::ProgressBar.new(value: 75, variant: :success)
      end
    end

    it "renders progress with bar" do
      html = subject.render
      expect(html).to include('<div class="progress" role="progressbar">')
      expect(html).to include('class="progress-bar bg-success"')
      expect(html).to include('aria-valuenow="75"')
      expect(html).to include('style="width: 75%"')
    end
  end
end
