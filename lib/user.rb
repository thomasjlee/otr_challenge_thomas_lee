class User
  attr_reader :last_name,
              :first_name,
              :gender,
              :favorite_color,
              :date_of_birth

  def initialize(user_data)
    @last_name      = user_data[0]
    @first_name     = user_data[1]
    @gender         = user_data[2]
    @favorite_color = user_data[3]
    @date_of_birth  = Date.strptime(user_data[4], "%m/%d/%Y")
  end

  def to_hash
    {
      last_name:      last_name,
      first_name:     first_name,
      gender:         gender,
      favorite_color: favorite_color,
      date_of_birth:  date_of_birth.strftime("%m/%d/%Y")
    }
  end
end
