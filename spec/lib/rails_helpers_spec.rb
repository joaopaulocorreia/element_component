# frozen_string_literal: true

RSpec.describe ElementComponent::RailsHelpers do
  subject(:object) { Class.new { include ElementComponent::RailsHelpers }.new }

  it "stores and exposes the view_context" do
    object.view_context = :ctx
    expect(object.view_context).to eq(:ctx)
  end

  it "exposes the view_context through #helpers" do
    object.view_context = :ctx
    expect(object.helpers).to eq(:ctx)
  end
end
