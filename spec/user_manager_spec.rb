require "date"

require_relative "../lib/user_manager.rb"
require_relative "../lib/user.rb"
require_relative "../lib/extractor.rb"

include Extractor

RSpec.describe UserManager do
  describe "#import" do
    before :each do
      @user_manager = UserManager.new
    end

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
end
