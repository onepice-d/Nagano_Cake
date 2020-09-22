class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

validates :last_name, presence: true
validates :first_name, presence: true
validates :last_name_kana, presence: true,
                 format: {
                   with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                   message: "全角カタカナのみで入力して下さい"
                 }
validates :first_name_kana, presence: true,
                 format: {
                   with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                   message: "全角カタカナのみで入力して下さい"
                 }

validates :postal_code, numericality: { only_integer: true }
# 郵便番号を数値だけ入力可,

validates :address, presence: true
validates :telephone_number, numericality: { only_integer: true }
# 電話番号を数値だけ入力可、
end
