require "spec_helper"
require "grape"
require "rack/test"

require_relative "../api/user_manager_api"

describe UserManagerAPI do
  include Rack::Test::Methods

  def app
    UserManagerAPI
  end

  describe "GET /records/hello" do
    it "responds with 200" do
      get "/records/hello"
      parsed_body = JSON.parse(last_response.body)
      expect(last_response.status).to be 200
      expect(parsed_body["message"]).to eq "test"
    end
  end
end
