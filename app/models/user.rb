class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  validates :nickname, presence: true
  validates :prefecture, presence: true
  
  has_many :posts
  has_many :responses
  has_many :post_likes
  has_many :response_likes
  has_many :notifications, dependent: :destroy

  rails_admin do
    list do
      field :email
      field :prefecture_i18n
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
      user.nickname = "ゲスト"
      user.prefecture = :tokyo_chuoku
    end
  end  

  enum prefecture: {
    tokyo_chuoku: 1, 
    tokyo_chiyodaku: 2, 
    tokyo_minatoku: 3,
    tokyo_shinjukuku: 4,
    tokyo_bunkyoku: 5,
    tokyo_taitoku: 6,
    tokyo_sumidaku: 7,
    tokyo_kotoku: 8,
    tokyo_shinagawaku: 9,
    tokyo_meguroku: 10,
    tokyo_otaku: 11,
    tokyo_setagayaku: 12,
    tokyo_shibuyaku: 13,
    tokyo_nakanoku: 14,
    tokyo_suginamiku: 15,
    tokyo_toshimaku: 16,
    tokyo_kitaku: 17,
    tokyo_arakawaku: 18,
    tokyo_itabashiku: 19,
    tokyo_nerimaku: 20,
    tokyo_adachiku: 21,
    tokyo_katsushikaku: 22,
    tokyo_edogawaku: 23,
    tokyo_musashino_shi: 24,
    tokyo_mitaka_shi: 25,
    tokyo_komae_shi: 26,
    tokyo_kokubnunji_shi: 27,
    kanagawa: 28,
    chiba: 29,
    saitama: 30,
    ibaraki: 31,
    others: 32
  }

  def prefecture_i18n
    I18n.t("activerecord.attributes.user.prefectures.#{prefecture}")
  end
end

