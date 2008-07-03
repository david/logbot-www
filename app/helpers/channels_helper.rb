module Merb
    module ChannelsHelper
      def time_to_date(time)
        Date.new time.year, time.month, time.day
      end

      def date_to_time(date)
        Time.parse date.to_s
      end

      def colored_nick(nick)
        @colored_nicks ||= {}

        @colored_nicks[nick] ||= "#%02x%02x%02x" % [rand(256), rand(256), rand(256)]
      end
    end
end
