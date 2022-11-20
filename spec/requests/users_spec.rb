require 'rails_helper'

RSpec.describe "Users", type: :request do

  create_user_params = {
      "user": {
      "email":"vk@gmail.com",
      "first_name":"vikas",
      "last_name":"kumar",
      "country_code":"+91",
      "mobile_number":"9876543210",
      "password":"password",
      "password_confirmation":"password"
    }
  }

  login_user_params = {
    "mobile_number":"9876543210",
    "password":"password"
  }

  invalid_login_user_params = {
    "mobile_number":"9876543210",
    "password":"admin123"
  }

  describe "POST /registration" do
    scenario "valid user attributes" do
      post 'http://127.0.0.1:3000/users/registration', params: create_user_params

      expect(response.status).to eq(201)
      json = JSON.parse(response.body).deep_symbolize_keys[:user]
      # check the value of the returned response hash
      expect(json[:email]).to eq('vk@gmail.com')
      expect(json[:first_name]).to eq('vikas')
      expect(json[:last_name]).to eq('kumar')
      expect(json[:country_code]).to eq('+91')
      expect(json[:mobile_number]).to eq('9876543210')


      # 1 new user record is created
      expect(User.count).to eq(1)

      # Optionally, you can check the latest record data
      expect(User.last.email).to eq('vk@gmail.com')
    end

    scenario "invalid user attributes" do
      post 'http://127.0.0.1:3000/users/registration', params: {
        "user": {
          "email":"",
          "first_name":"",
          "last_name":"",
          "country_code":"+91",
          "mobile_number":"9876543210",
          "password":"password",
          "password_confirmation":"password"
        }
      }
      expect(response.status).to eq(422)
      json = JSON.parse(response.body).deep_symbolize_keys[:errors]

      # check the value of the returned response hash
      expect(json[:email]).to eq(["can't be blank"])
      expect(json[:first_name]).to eq(["can't be blank"])
      expect(json[:last_name]).to eq(["can't be blank"])
    end
  end



  describe "PUT /users/login" do
    scenario "valid login credentials" do
      post 'http://127.0.0.1:3000/users/registration', params: create_user_params

      # expect(response.status).to eq(201)

      post 'http://127.0.0.1:3000/users/login', params: login_user_params
      expect(response.status).to eq(200)
      debugger
      json = JSON.parse(response.body).deep_symbolize_keys

      token = JsonWebToken.encode(user_id: User.last.id)

      expect(json[:token]).to eq(token)
    end

    scenario "invalid employment attributes" do
      post 'http://127.0.0.1:3000/users/registration', params: create_user_params

      post 'http://127.0.0.1:3000/users/login', params: invalid_login_user_params
      debugger
      expect(response.status).to eq(401)
      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:error]).to eq('unauthorized')
    end
  end
end
