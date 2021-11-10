require 'plutto/resources/customer_permission'

RSpec.describe Plutto::PermissionGroup do
  let(:data) do
    {
      id: 'permission-group_dc5b77670da8c8d2de2219c1',
      name: 'wow',
      permissions: [
        {
          limit: nil,
          name: 'Usuarios'
        },
        {
          limit: 'Infinity',
          name: 'Despachos'
        }
      ]
    }
  end

  let(:permission_group) { described_class.new(**data) }

  it 'create an instance of Pricing' do
    expect(permission_group).to be_an_instance_of(described_class)
    expect(permission_group.permissions).to all(be_a(Plutto::CustomerPermission))
  end

  it 'print the Pricing name and currency when to_s is called' do
    expect(permission_group.to_s).to eq('Permission group: Wow')
  end
end
