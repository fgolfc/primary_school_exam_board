require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:responses) }
    it { should have_many(:post_likes) }
    it { should have_many(:response_likes) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nickname) }
    it { should define_enum_for(:prefecture) }
  end

  describe '#prefecture_i18n' do
    before do
      I18n.locale = :ja
    end
    let(:user) { build(:user, prefecture: :tokyo_chuoku) }

    it 'returns the localized name for the prefecture' do
      puts "Localized value from I18n: #{I18n.t("activerecord.attributes.user.prefectures.tokyo_chuoku")}"
      puts "Value from prefecture_i18n: #{user.prefecture_i18n}"
      expect(user.prefecture_i18n).to eq(I18n.t("activerecord.attributes.user.prefectures.tokyo_chuoku"))
    end
  end
end
