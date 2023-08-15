class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :response, optional: true

  after_create :send_email_to_admin

  private

  def send_email_to_admin
    NotificationMailer.notify_admin(self).deliver_later
  end
end
