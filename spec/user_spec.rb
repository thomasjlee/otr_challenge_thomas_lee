require "date"

require_relative "../lib/user.rb"

RSpec.describe User do
  it "is instantiated with last_name, first_name, gender, favorite_color, and date_of_birth" do
    user = User.new(["Last", "First", "male", "blue", "1/1/2019"])
    expect(user).to be_a_kind_of User
  end

  it "converts date_of_birth to a Date" do
    user = User.new(["Last", "First", "male", "blue", "1/1/2019"])
    expect(user.date_of_birth).to be_a_kind_of Date
  end
end
