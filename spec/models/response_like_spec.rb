require 'rails_helper'

RSpec.describe ResponseLike, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:response) }
  end

  describe 'Validations' do
    subject { create(:response_like) }  
    it { should validate_uniqueness_of(:user_id).scoped_to(:response_id) }
  end

  describe 'Callbacks' do
    let(:response) { create(:response) }  
    let(:user) { create(:user) }  
    let!(:response_like) { build(:response_like, user: user, response: response) }

    it 'increments responses_likes_count after create' do
      expect { response_like.save }.to change { response.response_likes.count }.by(1)
    end
    
    it 'decrements responses_likes_count after destroy' do
      response_like.save
      expect { response_like.destroy }.to change { response.response_likes.count }.by(-1)
    end    
  end
end
