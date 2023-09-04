FactoryBot.define do
  factory :response do
    body { Faker::Lorem.paragraph }
    user
    post { create(:post, user: user) }  # 既存の user で post を作成
  end
end
