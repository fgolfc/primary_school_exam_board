FactoryBot.define do
  factory :post do
    # Postモデルの属性を定義します。具体的な属性はモデルによって異なりますが、一般的な例を以下に示します。
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    user # これは、PostがUserモデルに関連づけられている場合に関連を作成するためのものです。
    # 他の必要な属性も追加してください。
  end
end
