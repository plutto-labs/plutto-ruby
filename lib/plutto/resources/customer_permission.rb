class Plutto::CustomerPermission
  attr_reader :id, :name, :limit, :allowed, :current_usage

  def initialize(
    name:,
    limit:,
    allowed: nil,
    current_usage: nil,
    client: nil,
    **
  )
    @name = name
    @limit = limit
    @allowed = allowed
    @current_usage = current_usage
    @client = client
  end

  def to_s
    "CustomerPermission: #{name.capitalize}"
  end
end
