require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:admin) { create(:user, admin: true) }
  let!(:post) { create(:post) } 

  describe 'admin deletes a post' do
    before do
      sign_in admin
      visit post_path(post)
    end

    it 'deletes the post successfully' do
      expect(page).to have_link('投稿を削除する')

      accept_confirm do
        click_link '投稿を削除する'
      end

      expect(page).to have_content('Post was successfully destroyed.')
      expect(Post.exists?(post.id)).to be_falsey
    end
  end
end
