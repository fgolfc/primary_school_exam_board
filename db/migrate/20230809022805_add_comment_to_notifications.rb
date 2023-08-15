class AddCommentToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :comment, :text
  end
end
