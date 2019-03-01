require_relative "../lib/user_manager"
require_relative "../lib/extractor"
require_relative "../lib/user"

include Extractor

class UserManager
  def self.memo_user_manager
    @@memo_user_manager ||= UserManager.new
  end
end

class UserManagerAPI < Grape::API
  format :json

  # @@user_manager = UserManager.new

  helpers do
    def user_manager
      UserManager.memo_user_manager
    end
  end

  resources :records do
    params do
      requires :records, type: Array[String]
    end
    post do
      new_users = user_manager.add_records(params[:records])
      { records: new_users.map(&:to_hash) }
    end

    get :gender do
      { records: user_manager.sort_by(:gender).map(&:to_hash) }
    end

    get :birthdate do
      { records: user_manager.sort_by(:date_of_birth).map(&:to_hash) }
    end

    get :name do
      { records: user_manager.sort_by(:last_name_desc).map(&:to_hash) }
    end
  end
end
