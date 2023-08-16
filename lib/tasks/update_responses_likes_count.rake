namespace :db do
  desc 'Update responses_likes_count for each post'
  task update_responses_likes_count: :environment do
    Post.find_each do |post|
      post.update_column(:responses_likes_count, post.responses.sum(&:likes_count))
    end
  end
end