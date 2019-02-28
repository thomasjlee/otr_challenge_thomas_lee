class UserManager
  attr_reader :users

  def initialize
    @users = []
  end

  def import(file)
    records = extract(file)
    users.concat(records.map { |record| User.new(record) })
  end
end
