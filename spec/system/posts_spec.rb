require 'rails_helper'

RSpec.describe 'Post management', type: :system do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.skip_confirmation!
    user.save

    sign_in user
  end

  describe 'Post index' do
    it 'displays the posts' do
      visit posts_path
      expect(page).to have_content('質問投稿一覧') 
    end
  end
  
  describe 'Post creation' do
    it 'creates a new post' do
      visit new_post_path
      fill_in 'タイトル', with: 'Test Post Title' 
      fill_in '本文', with: 'Test Post Body' 
      click_button '投稿する' 
      expect(page).to have_content('Test Post Title')
      expect(page).to have_content('Test Post Body')
    end
  end
end
