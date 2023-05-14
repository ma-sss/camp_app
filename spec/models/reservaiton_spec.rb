require 'rails_helper'
describe Reservation do
  describe '#create' do

    it "day,admin_id,user_id,start_timeがある場合は登録できること" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
              address: "東京", telephone_number: "090-0000-0000")
        user = User.create(email: "test@example.com", password: "Password123")
        reservation = Reservation.create(day: Date.current + 2, admin_id: admin.id, user_id: user.id, start_time: Date.current + 2)
        expect(reservation).to be_valid
    end

    it "dayがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: nil, admin_id: admin.id, user_id: user.id, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:day]).to include("は必須項目です")
    end

    it "admin_idがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: Date.current + 2, admin_id: nil, user_id: user.id, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:admin_id]).to include("を入力してください")
    end

    it "user_idがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: Date.current + 1, admin_id: admin.id, user_id: nil, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:user_id]).to include("を入力してください")
    end

    it "start_timeがない場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: Date.current + 1, admin_id: admin.id, user_id: user.id, start_time: nil)
      reservation.valid?
      expect(reservation.errors[:start_time]).to include("を入力してください")
    end

    it "dayが過去の場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: Date.current - 1, admin_id: admin.id, user_id: user.id, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:day]).to include("は過去の日付は選択できません")
    end

    it "dayが当日の場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: Date.current , admin_id: admin.id, user_id: user.id, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:day]).to include("は当日は選択できません")
    end

    it "3ヶ月以降の日付の場合は登録できないこと" do
      admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
      user = User.create(email: "test@example.com", password: "Password123")
      reservation = Reservation.create(day: (Date.current >> 3) + 1 , admin_id: admin.id, user_id: user.id, start_time: Date.current + 2)
      reservation.valid?
      expect(reservation.errors[:day]).to include("は3ヶ月以降の日付は選択できません")
    end

  end
end