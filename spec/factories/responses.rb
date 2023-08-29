FactoryBot.define do
  factory :response do
    body { Faker::Lorem.paragraph }
    user # これにより、responseを作成する際に関連するuserも自動的に作成されます

    # 他の必要な属性も追加してください。
  end
end
