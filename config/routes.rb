Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  scope :api, module: :api, defaults: { format: :json } do
    devise_for :users, only: %i[sessions registrations], controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }

    resources :points do
      get :search, on: :collection
    end
  end

end

