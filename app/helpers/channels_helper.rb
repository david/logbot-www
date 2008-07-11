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
          entity = if m2 = /&\w+$/.match(m)
            m[/&\w+$/] = ""
            m2[0]
          else
            ""
          end

          "<a href=\"#{m}\">#{m}</a>#{entity}"
        end
      end
    end
end
