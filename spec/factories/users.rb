FactoryGirl.define do 
  factory :user do
    sequence(:email) { |n| "user#{n}@caraquri.com"}
    password "password"
  end
end
