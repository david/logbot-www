module Merb
    module ChannelsHelper
      def time_to_date(time)
        Date.new time.year, time.month, time.day
      end

      def date_to_time(date)
        Time.parse date.to_s
      end
    end
end
