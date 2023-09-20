require 'rails_helper'

RSpec.describe Response, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post).counter_cache(true) }
    it { should have_many(:response_likes).dependent(:destroy) }
  end

  describe 'Validations' do
    let(:response) { build(:response) } # FactoryBotを使用して、事前にResponseオブジェクトを生成しています。

    it 'is valid with valid attributes' do
      expect(response).to be_valid
    end

    it 'is not valid without a body' do
      response.body = nil
      expect(response).to_not be_valid
    end
  end
end