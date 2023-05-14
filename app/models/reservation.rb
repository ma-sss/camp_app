class Reservation < ApplicationRecord
  belongs_to :admin

  def self.reservations_after_three_month
      # 今日から3ヶ月先までのデータを取得
      reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
      # 配列を作成し、データを格納
      # DBアクセスを減らすために必要なデータを配列にデータを突っ込んでます
      reservation_data = []
      reservations.each do |reservation|
        reservations_hash = {}
        reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"))
        reservation_data.push(reservations_hash)
      end
      reservation_data
  end

  validates :day, presence: true
  validates :admin_id, presence: true
  validates :user_id, presence: true
  validates :start_time, presence: true
  validates :admin, presence: true
  validate :date_before_start
  validate :date_current_today
  validate :date_three_month_end

  def date_before_start
    if day.nil?
      errors.add(:day, "は必須項目です")
    elsif day < Date.current
      errors.add(:day, "は過去の日付は選択できません")
    end
  end

  def date_current_today
    if day.nil?
      errors.add(:day, "は必須項目です")
    elsif day == Date.current
      errors.add(:day, "は当日は選択できません")
    end
  end

  def date_three_month_end
    if day.nil?
      errors.add(:day, "は必須項目です")
    elsif (Date.current >> 3) < day
      errors.add(:day, "は3ヶ月以降の日付は選択できません")
    end
  end
end
