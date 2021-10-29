require 'plutto/resources/meter_event'

RSpec.describe Plutto::MeterEvent do
  let(:data) do
    {
      id: "event_422515723726ce978ee454c6",
      timestamp: "2021-10-27T15:01:57.710Z",
      amount: 4.20,
      action: "increment",
      created_at: "2021-10-27T15:01:57.736Z",
      idempotency_key: nil,
      meter_id: "meter_5ef790a8ee1f2d1710cd2f13",
      customer_id: "customer_dde1c281812f0af2fd1ba08d"
    }
  end

  let(:meter_event) { described_class.new(**data) }

  it 'create an instance of MeterEvent' do
    expect(meter_event).to be_an_instance_of(described_class)
  end

  it "print the MeterEvent information when to_s is called" do
    expect(meter_event.to_s).to eq(
      "Increment 4.2 to meter_5ef790a8ee1f2d1710cd2f13 for customer_dde1c281812f0af2fd1ba08d"
    )
  end
end
