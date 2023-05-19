class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX ,
      message: "は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります" }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :address, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_TELEPHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/
  validates :telephone_number, presence: true, format: { with: VALID_TELEPHONE_NUMBER_REGEX, message: "を正しい形式で入力してください。" }, uniqueness: true

  has_many :reservations
  has_many :favorites, dependent: :destroy
end
