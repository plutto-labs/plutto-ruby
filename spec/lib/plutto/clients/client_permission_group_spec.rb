require 'plutto/client'

RSpec.describe Plutto::ClientPermissionGroup do
  let(:api_key) { 'sk_live_0a641854b17cdfed9e98eb7cd3e9e2bfc2687a37470cc8ce71f31c49e33d037f' }
  let(:client) { described_class.new(api_key) }

  describe '.new' do
    it 'create an instance Client' do
      expect(client).to be_an_instance_of(described_class)
    end
  end

  describe '#get_permission_groups' do
    it 'returns an array of instances', :vcr do
      permission_groups = client.get_permission_groups
      expect(permission_groups).to all(be_a(Plutto::PermissionGroup))
    end

    it_behaves_like 'unauthorized endpoint', 'get_permission_groups'
  end
end
