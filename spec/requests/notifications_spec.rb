require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) } # FactoryBotを用いたサンプルデータの作成
    let(:post_instance) { create(:post) } # 同様にサンプルデータの作成

    it "creates a new notification" do
      expect {
        post :create, params: {
          user_id: user.id,
          post_id: post_instance.id,
          action: 'some_action',
          comment: 'This is a test comment'
        }
      }.to change(Notification, :count).by(1)
    end

    # 他のテストも追加できます
  end
end
