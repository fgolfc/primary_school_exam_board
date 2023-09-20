require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:post_likes).dependent(:destroy) }
    it { should have_many(:responses).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'Validations' do
    let(:post) { build(:post) }

    it 'is valid with valid attributes' do
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post.title = nil
      expect(post).to_not be_valid
    end
  end
end