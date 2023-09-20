require 'rails_helper'

RSpec.describe PostLike, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Validations' do
    subject { create(:post_like) } 
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe 'Callbacks' do
    let(:post) { create(:post) }  
    let(:user) { create(:user) }  
    let!(:post_like) { build(:post_like, user: user, post: post) }

    it 'increments posts_likes_count after create' do
      expect { post_like.save }.to change { post.post_likes_count }.by(1)
    end

    it 'decrements posts_likes_count after destroy' do
      post_like.save
      expect { post_like.destroy }.to change { post.post_likes_count }.by(-1)
    end
  end
end
