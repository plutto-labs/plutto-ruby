require "spec_helper"

describe Plutto-ruby do
  before do
    helper_example
  end

  it "has a version number" do
    expect(Plutto-ruby::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
