FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "user#{100 + n}" }
    sequence(:email) { |n| "user#{100 + n}@test.com" }
    password { "password" }
    prefecture { :tokyo_chuoku }
    confirmed_at { Time.now }
  end
end
