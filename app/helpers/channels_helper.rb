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

      def content(content)
        linkify_uris(h(content))
      end

      def linkify_uris(content)
        content.gsub %r{\b(\w+://\S+\w+/?)} do |m| 
          match, entity, _ = *m.partition(/&\w+$/)
          "<a href=\"#{match}\">#{match}</a>#{entity}#{_}"
        end
      end
    end
end
