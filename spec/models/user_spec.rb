require 'rails_helper'
describe User do
  describe '#create' do

    it "emailとpasswordがある場合は登録できること" do
        user = User.create(name: "user1", email: "test@example.com", password: "Password123")
        user.valid?
        expect(user).to be_valid
    end

    it "nameがない場合は登録できないこと" do
        user = User.create(name: nil, email: "test@example.com", password: "Password123")
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
        user = User.create(name: "user1", email: nil, password: "Password123")
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
        user = User.create(name: "user1", email: "test@example.com", password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
    end

    it "emailとpasswordがない場合は登録できないこと" do
        user = User.create(name: "user1", email: nil, password: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailに@がない場合は登録できないこと" do
        user = User.create(name: "user1", email: "testexample.com", password: nil)
        user.valid?
        expect(user.errors[:email]).to include("は不正な値です")
    end

    it "userが30文字以上の場合は登録できないこと" do
        user = User.create(name: "1user1user1user1user1user1user1user1user1user1user1", email: "test@example.com",
             password: nil)
        user.valid?
        expect(user.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "emailが256文字以上の場合は登録できないこと" do
        user = User.create(name: "user1", email: "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@example.com",
             password: "Password123")
        user.valid?
        expect(user.errors[:email]).to include("は255文字以内で入力してください")
    end

    it "nameが重複している場合は登録できないこと" do
        user = User.create(name: "user1", email: "test@example.com", password: "Password123")
        user1 = FactoryBot.build(:user)
        user1.valid?
        expect(user1.errors[:name]).to include("はすでに存在します")
    end

    it "emailが重複している場合は登録できないこと" do
        user = User.create(name: "user1", email: "test@example.com", password: "Password123")
        user1 = FactoryBot.build(:user)
        user1.valid?
        expect(user1.errors[:email]).to include("はすでに存在します")
    end

  end
end