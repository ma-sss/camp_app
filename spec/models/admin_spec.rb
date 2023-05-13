require 'rails_helper'
describe Admin do
  describe '#create' do

    it "email,password,name,address,telephone_numberがある場合は登録できること" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
             address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin).to be_valid
    end

    it "emailがない場合は登録できないこと" do
        admin = Admin.create(email: nil, password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: nil, name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:password]).to include("を入力してください")
    end

    it "nameがない場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: nil,
            address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:name]).to include("を入力してください")
    end

    it "addressがない場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: nil, telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:address]).to include("を入力してください")
    end

    it "telephone_numberがない場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: nil)
        admin.valid?
        expect(admin.errors[:telephone_number]).to include("を入力してください")
    end

    it "telephone_numberの入力が正しくない場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "000-0000-0000")
        admin.valid?
        expect(admin.errors[:telephone_number]).to include("を正しい形式で入力してください。")
    end

    it "emailに@がない場合は登録できないこと" do
        admmin = Admin.create(email: "testexample.com",  password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admmin.valid?
        expect(admmin.errors[:email]).to include("は不正な値です")
    end

    it "emailが256文字以上の場合は登録できないこと" do
        admin = Admin.create(email: "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest@example.com",
             password: "Password123", name: "キャンプ場123",address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:email]).to include("は255文字以内で入力してください")
    end

    it "nameが51文字以上の場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com",
             password: "Password123", name: "キャンプ場1231231231231231231231231231231231231231231231",address: "東京", telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:name]).to include("は50文字以内で入力してください")
    end

    it "addressが51文字以上の場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com",password: "Password123", name: "キャンプ場123",
            address: "東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東京東",
            telephone_number: "090-0000-0000")
        admin.valid?
        expect(admin.errors[:address]).to include("は50文字以内で入力してください")
    end

    it "emailが重複している場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin1 = FactoryBot.build(:admin)
        admin1.valid?
        expect(admin1.errors[:email]).to include("はすでに存在します")
    end

    it "nameが重複している場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin1 = FactoryBot.build(:admin)
        admin1.valid?
        expect(admin1.errors[:name]).to include("はすでに存在します")
    end

    it "addressが重複している場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin1 = FactoryBot.build(:admin)
        admin1.valid?
        expect(admin1.errors[:address]).to include("はすでに存在します")
    end

    it "telephone_numberが重複している場合は登録できないこと" do
        admin = Admin.create(email: "test@example.com", password: "Password123", name: "キャンプ場123",
            address: "東京", telephone_number: "090-0000-0000")
        admin1 = FactoryBot.build(:admin)
        admin1.valid?
        expect(admin1.errors[:telephone_number]).to include("はすでに存在します")
    end
  end
end