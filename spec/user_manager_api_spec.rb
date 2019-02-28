require "spec_helper"
require "grape"
require "rack/test"

require_relative "../api/user_manager_api"

describe UserManagerAPI do
  include Rack::Test::Methods

  def app
    UserManagerAPI
  end

  describe "GET /records/gender" do
    xit "responds with 200" do
      get "/records/gender"
      expect(last_response.status).to be 200
    end

    xit "responds with records sorted by gender" do
      get "/records/gender"
      expect(last_response.body).to eq "foo"
    end
  end
end
