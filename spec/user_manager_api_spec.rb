require "spec_helper"
require "grape"
require "rack/test"

require_relative "../api/user_manager_api"

describe UserManagerAPI do
  include Rack::Test::Methods

  def app
    UserManagerAPI
  end

  describe "POST /records" do
    after :all do
      UserManager.memo_user_manager.users = []
    end

    it "responds with newly added record" do
      post("/records", { records: ["last,first,male,blue,1/1/1111"]})
      body = JSON.parse(last_response.body)
      expect(body["records"].length).to be 1
    end

    it "can be used to add multiple records" do
      records = [
        "one_last,one_first,male,blue,1/1/1111",
        "two_last,two_first,female,red,2/2/22222"
      ]
      post("/records", { records: records })
      body = JSON.parse(last_response.body)
      expect(body["records"].length).to be 2
    end
  end

  describe "GET /records/gender" do
    before :all do
      male_a   = "A,name,male,blue,1/1/1111"
      male_z   = "Z,name,male,red,2/2/2222"
      female_a = "A,name,female,yellow,3/3/3333"
      female_z = "Z,name,female,purple,4/4/4444"
      records = [male_a, male_z, female_z, female_z]
      post("/records", { records: records })
    end

    after :all do
      UserManager.memo_user_manager.users = []
    end

    it "responds with 200" do
      get "/records/gender"
      expect(last_response.status).to be 200
    end

    it "responds with records sorted by gender" do
      get "/records/gender"
      records = JSON.parse(last_response.body)["records"]

      female_index = records.find_index { |user|
        user["last_name"] == "Z" && user["gender"] == "female" }

      male_index = records.find_index { |user|
        user["last_name"] == "Z" && user["gender"] == "male" }

      expect(records.length).to be 4
      expect(female_index < male_index).to be true
    end
  end

  describe "GET /records/birthdate" do
    before :all do
      baby  = "baby,name,male,blue,1/1/2019"
      teen  = "teen,name,male,red,1/1/2005"
      adult = "adult,name,female,yellow,1/1/1990"
      elder = "elder,name,female,purple,1/1/1970"
      records = [baby, teen, adult, elder]
      post("/records", { records: records })
    end

    after :all do
      UserManager.memo_user_manager.users = []
    end

    it "responds with 200" do
      get "/records/birthdate"
      expect(last_response.status).to be 200
    end

    it "responds with records sorted by date_of_birth" do
      get "/records/birthdate"
      records = JSON.parse(last_response.body)["records"]

      expect(records.length).to be 4
      expect(records[0]["last_name"]).to eq "elder"
      expect(records[1]["last_name"]).to eq "adult"
      expect(records[2]["last_name"]).to eq "teen"
      expect(records[3]["last_name"]).to eq "baby"
    end
  end

  describe "GET /records/name" do
    before :all do
      adams = "adams,name,male,blue,1/1/2019"
      baker = "baker,name,male,red,1/1/2005"
      clark = "clark,name,female,yellow,1/1/1990"
      dixon = "dixon,name,female,purple,1/1/1970"
      records = [adams, baker, clark, dixon]
      post("/records", { records: records })
    end

    after :all do
      UserManager.memo_user_manager.users = []
    end

    it "responds with 200" do
      get "/records/name"
      expect(last_response.status).to be 200
    end

    it "responds with records sorted by last_name, descending" do
      get "/records/name"
      records = JSON.parse(last_response.body)["records"]

      expect(records.length).to be 4
      expect(records[0]["last_name"]).to eq "dixon"
      expect(records[1]["last_name"]).to eq "clark"
      expect(records[2]["last_name"]).to eq "baker"
      expect(records[3]["last_name"]).to eq "adams"
    end
  end
end
