FactoryBot.define do
  factory :user do
    sequence(:nickname) do |n|
      raise "User number limit exceeded!" if n > 50
      "user#{100 + n}"
    end
    sequence(:email) do |n|
      raise "Email limit exceeded!" if n > 50
      "user#{100 + n}@test.com"
    end
    password { "password" }
    prefecture { :tokyo_chuoku }
    confirmed_at { Time.now }
  end
end
