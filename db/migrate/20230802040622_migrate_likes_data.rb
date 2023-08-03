class MigrateLikesData < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO post_likes(user_id, post_id, created_at, updated_at)
        SELECT user_id, likeable_id, created_at, updated_at
        FROM likes
        WHERE likeable_type = 'Post';

      INSERT INTO response_likes(user_id, response_id, created_at, updated_at)
        SELECT user_id, likeable_id, created_at, updated_at
        FROM likes
        WHERE likeable_type = 'Response';
    SQL
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
