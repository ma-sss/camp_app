require 'rails_helper'
describe Favorite do
  describe '#create' do

    it "admin_id,user_idがある場合は登録できること" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      favorite = Favorite.create(admin_id: admin.id, user_id: user.id)
      expect(favorite).to be_valid
    end

    it "admin_idがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      favorite = Favorite.create(admin_id: nil, user_id: user.id)
      favorite.valid?
      expect(favorite.errors[:admin_id]).to include("を入力してください")
    end

    it "user_idがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      favorite = Favorite.create(admin_id: admin.id, user_id: nil)
      favorite.valid?
      expect(favorite.errors[:user_id]).to include("を入力してください")
    end

  end
end