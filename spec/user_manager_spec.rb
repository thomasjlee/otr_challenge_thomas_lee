require "date"

require_relative "../lib/user_manager.rb"
require_relative "../lib/user.rb"
require_relative "../lib/extractor.rb"

include Extractor

RSpec.describe UserManager do
  before :each do
    @user_manager = UserManager.new
  end

  describe "#import" do
    context "given a file with comma-delimited values" do
      it "populates users with new User instances" do
        file = "./spec/fixtures/comma_delimited.csv"
        @user_manager.import(file)
        expect(@user_manager.users.length).to be 2
        expect(@user_manager.users).to include(a_kind_of(User))
      end
    end

    context "given a file with pipe-delimited values" do
      it "populates users with new User instances" do
        file = "./spec/fixtures/pipe_delimited.txt"
        @user_manager.import(file)
        expect(@user_manager.users.length).to be 2
        expect(@user_manager.users).to include(a_kind_of(User))
      end
    end

    context "given a file with space-delimited values" do
      it "populates users with new User instances" do
        file = "./spec/fixtures/space_delimited.txt"
        @user_manager.import(file)
        expect(@user_manager.users.length).to be 2
        expect(@user_manager.users).to include(a_kind_of(User))
      end
    end

    it "importing multiple files appends to users" do
      file_one = "./spec/fixtures/space_delimited.txt"
      file_two = "./spec/fixtures/pipe_delimited.txt"

      @user_manager.import(file_one)
      expect(@user_manager.users).to include(a_kind_of(User))
      expect(@user_manager.users.length).to be 2

      @user_manager.import(file_two)
      expect(@user_manager.users.length).to be 4
    end
  end

  describe "#sort_by" do
    it "raises ArgumentError given an invalid field argument" do
      expect {
        @user_manager.sort_by(:invalid)
      }.to raise_error ArgumentError
    end

    it "sorts users by gender: females before males, then by last_name ascending" do
      male_a   = double("Male user with last name A", gender: "male", last_name: "A")
      male_z   = double("Male user with last name Z", gender: "male", last_name: "Z")
      female_a = double("Female user with last name A", gender: "female", last_name: "A")
      female_z = double("Female user with last name Z", gender: "female", last_name: "Z")

      @user_manager.users = [male_a, male_z, female_a, female_z]
      sorted_by_gender = @user_manager.sort_by(:gender)

      expect(sorted_by_gender.first.gender).to eq "female"
      expect(sorted_by_gender.first.last_name).to eq "A"

      expect(sorted_by_gender.last.gender).to eq "male"
      expect(sorted_by_gender.last.last_name).to eq "Z"
    end

    it "sorts users by date_of_birth, ascending" do
      baby  = double(date_of_birth: Date.new(2019, 01, 01))
      teen  = double(date_of_birth: Date.new(2005, 01, 01))
      adult = double(date_of_birth: Date.new(1990, 01, 01))
      elder = double(date_of_birth: Date.new(1970, 01, 01))

      @user_manager.users = [baby, teen, adult, elder]
      sorted_users = @user_manager.sort_by(:date_of_birth)

      first_sorted_user = sorted_users.first
      last_sorted_user  = sorted_users.last
      expect(first_sorted_user.date_of_birth < last_sorted_user.date_of_birth).to be true
    end

    it "sorts users by last_name, descending" do
      adams = double(last_name: "Adams")
      baker = double(last_name: "Baker")
      clark = double(last_name: "Clark")
      dixon = double(last_name: "Dixon")

      @user_manager.users = [adams, baker, clark, dixon]
      sorted_users = @user_manager.sort_by(:last_name_desc)

      expect(sorted_users.first.last_name).to eq "Dixon"
      expect(sorted_users.last.last_name).to eq "Adams"
    end

    it "ignores case when sorting by last_name, descending" do
      adams = double(last_name: "adams")
      baker = double(last_name: "Baker")

      @user_manager.users = [adams, baker]
      sorted_users = @user_manager.sort_by(:last_name_desc)

      expect(sorted_users.first.last_name).to eq "Baker"
      expect(sorted_users.last.last_name).to eq "adams"
    end
  end
end
