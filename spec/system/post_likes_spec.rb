# spec/system/post_likes_spec.rb
require 'rails_helper'

RSpec.describe 'PostLikes', type: :system, js: true do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }

  before do
    driven_by(:selenium_chrome)
    sign_in user
    visit posts_path # ここを変更して、投稿一覧ページに移動します
  end

  describe 'liking a post' do
    it 'allows a user to like a post and updates the UI accordingly' do
      expect(page).to have_content(post.body)
      
      within "#like-button-post-#{post.id}" do
        click_on '❤️ いいね'
      end

      within "#like-button-post-#{post.id}" do
        expect(page).to have_content('いいねをキャンセル') # 期待するボタンの変更
      end
      expect(page).to have_selector("#like-count-post-#{post.id}", text: '1') # 期待するいいねのカウント数
    end
  end

  describe 'unliking a post' do
    before do
      create(:post_like, user: user, post: post)
      visit posts_path # ここも変更して、投稿一覧ページに移動します
    end

    it 'allows a user to unlike a post and updates the UI accordingly' do
      within "#like-button-post-#{post.id}" do
        click_on 'いいねをキャンセル'
      end

      within "#like-button-post-#{post.id}" do
        expect(page).to have_content('❤️ いいね') # '❤️ いいね' ボタンに戻ることを確認
      end
      expect(page).to have_selector("#like-count-post-#{post.id}", text: '0') # 期待するいいねのカウント数
    end
  end
end
