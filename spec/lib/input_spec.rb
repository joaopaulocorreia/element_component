RSpec.describe ElementComponent::Input do
  subject { ElementComponent::Input.new }

  context 'When create empty element' do
    it { expect(subject.element).to eq('input') }
    it { expect(subject.contents).to eq([]) }
    it { expect(subject.attributes[:type]).to eq(['text']) }
  end
end
