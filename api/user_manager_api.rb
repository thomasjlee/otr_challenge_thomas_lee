require_relative "../lib/user_manager"
require_relative "../lib/extractor"
require_relative "../lib/user"

include Extractor

@@user_manager = UserManager.new

class UserManagerAPI < Grape::API
  format :json

  helpers do
    def user_manager
      @@user_manager
    end
  end

  resources :records do
    params do
      requires :records, type: Array[String]
    end
    post do
      user_manager.add_records(params[:records])
    end

    get :gender do
      { records: @@user_manager.users }
    end
  end
end
