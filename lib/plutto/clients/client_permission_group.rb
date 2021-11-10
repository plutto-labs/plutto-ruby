require 'plutto/resources/permission_group'

class Plutto::ClientPermissionGroup < Plutto::Client
  def get_permission_groups
    all("permission_groups")
  end
end
