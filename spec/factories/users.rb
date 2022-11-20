FactoryBot.define do
  password = Faker::Internet.password
  factory :user do
    email {Faker::Internet.email}
    first_name {Faker::Name.name}
    last_name {Faker::Name.name}
    country_code { "+91" }
    mobile_number {Faker::PhoneNumber.phone_number}
    password { password }
    password_confirmation { password} 
  end
end
