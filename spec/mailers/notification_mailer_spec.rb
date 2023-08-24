require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe 'notify_admin' do
    let(:user) { create(:user) }
    let(:post_instance) { create(:post) }
    let(:notification) { create(:notification, user: user, post: post_instance, comment: 'This is a test comment') }

    let(:mail) { NotificationMailer.notify_admin(notification) }

    it 'renders the headers' do
      expect(mail.subject).to eq('投稿通報連絡')
      expect(mail.to).to eq(['cf.ts.fujimoto@gmail.com'])
      expect(mail.from).to eq(['from@example.com']) # これはあなたのデフォルトのfromアドレスに応じて変更してください。
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include(user.nickname)
      expect(mail.text_part.body.to_s).to include(post_instance.title)
      expect(mail.text_part.body.to_s).to include('This is a test comment')
    end    
  end
end