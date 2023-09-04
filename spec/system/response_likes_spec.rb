require 'rails_helper'

RSpec.describe 'ResponseLikes', type: :system, js: true do
  let(:user_for_post) { create(:user) }
  let(:user_for_response) { create(:user) }
  let!(:post) { create(:post, user: user_for_post) }
  let!(:response) { create(:response, user: user_for_response, post: post) }

  before do
    driven_by(:selenium_chrome)
    sign_in user_for_response
    visit post_path(post)
  end

  describe 'liking a response' do
    it 'allows a user to like a response and updates the UI accordingly' do
      within "#like-button-response-#{response.id}" do
        click_on '❤️ いいね'
      end

      within "#like-button-response-#{response.id}" do
        expect(page).to have_content('いいねをキャンセル') # 期待するボタンの変更
      end
      expect(page).to have_selector("#like-count-response-#{response.id}", text: '1') # 期待するいいねのカウント数
    end
  end

  describe 'unliking a response' do
    before do
      create(:response_like, user: user_for_response, response: response)
      visit post_path(post) # 再度ポストの詳細ページに移動
    end

    it 'allows a user to unlike a response and updates the UI accordingly' do
      within "#like-button-response-#{response.id}" do
        click_on 'いいねをキャンセル'
      end

      within "#like-button-response-#{response.id}" do
        expect(page).to have_content('❤️ いいね') # '❤️ いいね' ボタンに戻ることを確認
      end
      expect(page).to have_selector("#like-count-response-#{response.id}", text: '0') # 期待するいいねのカウント数
    end
  end
end
