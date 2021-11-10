require 'plutto/resources/customer_permission'
class Plutto::PermissionGroup
  attr_reader :id, :name, :permissions

  def initialize(
    id:,
    name:,
    permissions:,
    client: nil,
    **
  )
    @id = id
    @client = client
    @name = name
    @permissions = permissions.nil? ? [] : permissions.map { |data| create_permisson(data) }
  end

  def to_s
    "Permission group: #{name.capitalize}"
  end

  private

  def create_permisson(data)
    Plutto::CustomerPermission.new(**data)
  end
end
