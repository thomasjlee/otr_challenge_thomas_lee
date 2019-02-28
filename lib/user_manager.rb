class UserManager
  attr_accessor :users

  VALID_SORT_KEYS = [:gender, :date_of_birth, :last_name_desc]

  def initialize
    @users = []
  end

  def import(file)
    records = extract(file)
    users.concat(records.map { |record| User.new(record) })
  end

  def sort_by(field)
    unless VALID_SORT_KEYS.include?(field)
      raise ArgumentError, "valid sort keys include #{VALID_SORT_KEYS}"
    end

    case field
    when :gender
      users.sort { |a, b| [a.gender, a.last_name] <=> [b.gender, b.last_name] }
    when :date_of_birth
      users.sort_by { |user| user.date_of_birth }
    when :last_name_desc
      users.sort_by { |user| -user.last_name[0].downcase.ord }
    end
  end
end
