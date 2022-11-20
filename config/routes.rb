Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index], :defaults => { :format => 'json' } do
    collection do
      get 'generate_otp'
      get 'validate_otp'
      get 'resend_otp'
      post 'reset_password'
      post 'registration'
      post 'login'
      get 'profile'
    end
  end
end
