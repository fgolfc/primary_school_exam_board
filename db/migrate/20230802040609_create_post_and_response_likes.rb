class CreatePostAndResponseLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :post_likes do |t|
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
    end

    create_table :response_likes do |t|
      t.bigint :user_id, null: false
      t.bigint :response_id, null: false
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
    end
  end
end
