require 'rails_helper'

RSpec.describe ResponseLike, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:response) }
  end

  describe 'validations' do
    subject { create(:response_like) } 
    it { should validate_uniqueness_of(:user_id).scoped_to(:response_id) }
  end
end
