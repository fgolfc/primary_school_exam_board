require 'rails_helper'

RSpec.describe 'Posts index sorting', type: :system do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.skip_confirmation!
    user.save
    visit posts_path
  end

  it 'has a link to sort posts by the number of responses' do
    expect(page).to have_link('回答数が多い順に並べ替える')
  end

  it 'has a link to sort posts by creation date' do
    expect(page).to have_link('投稿日順に並べ替える')
  end

  it 'sorts posts by the number of responses when clicked' do
    click_link '回答数が多い順に並べ替える'
    expect(current_url).to include('order_by=responses_count')
  end

  it 'sorts posts by creation date when clicked' do
    click_link '投稿日順に並べ替える'
    expect(current_url).to include('q%5Bs%5D=created_at+desc')
  end
end