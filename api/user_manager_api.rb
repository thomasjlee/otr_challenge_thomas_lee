class UserManagerAPI < Grape::API
  format :json

  resources :records do
    get :hello do
      { message: "test" }
    end
  end
end
