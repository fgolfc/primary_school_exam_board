require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, admin: true) }
  let!(:other_user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.skip_confirmation!
    user.save
  end

  describe 'show user page' do
    context 'when accessed by the user itself' do
      before do
        sign_in user
        visit user_path(user)
      end

      it 'displays the user details' do
        expect(page).to have_content(user.nickname)
      end
    end

    context 'when accessed by an admin' do
      before do
        sign_in admin
        visit user_path(user)
      end

      it 'displays the user details' do
        expect(page).to have_content(user.nickname)
      end
    end

    context 'when accessed by another user' do
      before do
        sign_in other_user
        visit user_path(user)
      end

      it 'redirects to the root path' do
        expect(page).to have_current_path(root_path)
      end

      it 'displays a no permission message' do
        expect(page).to have_content("You do not have permission to access this page.")
      end
    end
  end
end
