module ReservationsHelper

    def check_reservation(reservations, day)
        result = false
        reservations_count = reservations.count
        # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返します
        if reservations_count > 1
          reservations.each do |reservation|
            result = reservation[:day].eql?(day.strftime("%Y-%m-%d"))
            return result if result
          end
        elsif reservations_count == 1
          result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d"))
          return result if result
        end
        return result
      end

end
