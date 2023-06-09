class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX ,
      message: "は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります" }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  has_many :favorites, dependent: :destroy
  
  def favorite_find(admin_id)
    favorites.where(admin_id: admin_id).exists?
  end
end
