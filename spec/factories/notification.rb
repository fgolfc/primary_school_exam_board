FactoryBot.define do
  factory :notification do
    user
    post
    comment { 'Sample Comment' }
    # 必要に応じて他の属性も追加します
  end
end
