require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  before do
    user.send_confirmation_instructions
  end

  it 'sends a confirmation email' do
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

  def confirm_email
    open_email(user.email)
    current_email.click_link 'アカウントを確認'
  end

  describe 'show user page' do
    context 'when accessed by the user itself' do
      before do
        sign_in user
        confirm_email
        visit user_path(user)
      end

      it 'displays the user details' do
        expect(page).to have_content(user.nickname)
      end
    end

    context 'when accessed by an admin' do
      before do
        sign_in admin
        confirm_email
        visit user_path(user)
      end

      it 'displays the user details' do
        expect(page).to have_content(user.nickname)
      end
    end

    context 'when accessed by another user' do
      let(:other_user) { create(:user) }
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
