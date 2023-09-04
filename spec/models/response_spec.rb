RSpec.describe Response, type: :model do
  describe "validations" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let!(:response) { build(:response, user: user, post: post) } # buildは保存しない

    it "should not allow the author to respond to their own post" do
      expect(response).not_to be_valid
      expect(response.errors[:base]).to include("質問者は回答できません。")
    end
  end
end
