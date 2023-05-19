FactoryBot.define do
  factory :admin do
    email { "test@example.com" }
    password              { "Password123" }
    password_confirmation { "Password123" }
    name { "キャンプ場123" }
    address { "東京" }
    telephone_number { "090-0000-0000" }
  end
end