class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)(?=.*?[!-\/:-@\[-`{-~\\]])[!-~]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX ,
      message: "は半角英小文字・大文字・数字・記号を含めて設定してください" }
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true

  has_many :reservations
  has_many :favorites, dependent: :destroy
end
