require 'rails_helper'

RSpec.describe PostLike, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    subject { create(:post_like) } 
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end
end
