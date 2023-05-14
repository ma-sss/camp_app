FactoryBot.define do
    factory :reservation do
      day {Date.current + 1}
      admin_id {1}
      user_id {1}
      start_time {Date.current + 1}
      association :admin, factory: :admin
    end
  end