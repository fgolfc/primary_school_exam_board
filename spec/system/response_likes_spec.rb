# spec/system/response_likes_spec.rb
require 'rails_helper'

RSpec.describe 'ResponseLikes', type: :system do
  let(:user) { create(:user) }
  let(:response) { create(:response) }
  let(:post) { response.post } # レスポンスが紐付けられているポストを取得

  before do
    driven_by(:selenium_chrome)
    sign_in user
    visit post_path(post) # ポストの詳細ページに移動
  end

  describe 'liking a response' do
    it 'allows a user to like a response and updates the UI accordingly' do
      within "#like-button-#{response.id}" do
        click_on '❤️ いいね'
      end
      
      expect {
        # '❤️ いいね' ボタンがクリックされた後の変更を確認
      }.to change(ResponseLike, :count).by(1)

      within "#like-button-#{response.id}" do
        expect(page).to have_content('いいねをキャンセル') # 期待するボタンの変更
      end
      expect(page).to have_selector("#like-count-#{response.id}", text: '1') # 期待するいいねのカウント数
    end
  end

  describe 'unliking a response' do
    before do
      create(:response_like, user: user, response: response)
      visit post_path(post) # 再度ポストの詳細ページに移動
    end

    it 'allows a user to unlike a response and updates the UI accordingly' do
      within "#like-button-#{response.id}" do
        click_on 'いいねをキャンセル'
      end

      expect {
        # 'いいねをキャンセル' ボタンがクリックされた後の変更を確認
      }.to change(ResponseLike, :count).by(-1)

      within "#like-button-#{response.id}" do
        expect(page).to have_content('❤️ いいね') # '❤️ いいね' ボタンに戻ることを確認
      end
      expect(page).to have_selector("#like-count-#{response.id}", text: '0') # 期待するいいねのカウント数
    end
  end
end
