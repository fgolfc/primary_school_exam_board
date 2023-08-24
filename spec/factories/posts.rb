FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    user # これにより、postを作成する際に関連するuserも自動的に作成されます
    # 他の必要な属性も追加してください。
  end
end
