RSpec.describe ElementComponent::Element do
  subject { ElementComponent::Element.new('p') }

  describe 'Create empty element' do
    it { expect(subject.element).to eq('p') }
    it { expect(subject.contents).to eq([]) }
    it { expect(subject.attributes).to eq({}) }
    it { expect(subject.render).to eq('<p></p>') }
  end

  describe 'Add content to element' do
    before { subject.add_content('content one') }

    context 'One content' do
      it { expect(subject.contents.count).to eq(1) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq('content one') }
      it { expect(subject.render).to eq('<p>content one</p>') }
    end

    context 'Two contents' do
      before { subject.add_content('content two') }

      it { expect(subject.contents.count).to eq(2) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq('content one') }
      it { expect(subject.contents.last).to eq('content two') }
      it { expect(subject.render).to eq('<p>content onecontent two</p>') }
    end

    context 'When content have type Element' do
      before { subject.add_content(ElementComponent::Element.new('h1')) }

      it { expect(subject.contents.count).to eq(2) }
      it { expect(subject.contents.class).to eq(Array) }
      it { expect(subject.contents.first).to eq('content one') }
      it { expect(subject.contents.last.class).to eq(ElementComponent::Element) }
      it { expect(subject.render).to eq('<p>content one<h1></h1></p>') }
    end

    context 'Reset contents and add new value' do
      before { subject.add_content('new content', reset: true) }

      it { expect(subject.contents.count).to eq(1) }
      it { expect(subject.contents).to eq(['new content']) }
    end
  end

  describe 'Add attribute to element' do
    before { subject.add_attribute(:class, 'margin') }

    context 'Add new attribute' do
      it { expect(subject.attributes.has_key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({class: ['margin']}) }
      it { expect(subject.render).to eq('<p class="margin"></p>') }
    end

    context 'Add more value to the some attribute' do
      before { subject.add_attribute(:class, 'color') }

      it { expect(subject.attributes.has_key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({class: ['margin', 'color']}) }
      it { expect(subject.render).to eq('<p class="margin color"></p>') }
    end

    context 'Reset attributes and add new value' do
      before { subject.add_attribute(:class, 'padding', reset: true) }

      it { expect(subject.attributes.has_key?(:class)).to be_truthy }
      it { expect(subject.attributes).to eq({class: ['padding']}) }
      it { expect(subject.render).to eq('<p class="padding"></p>') }
    end
  end
end
