require 'logbot/event'

class Channels < Application
  
  def index
    render
  end

  def show
    @channel = params[:channel]

    year, month, day = *params.values_at(:year, :month, :day)

    if year && month && day
      _begin = Time.mktime year, month, day
      _end   = _begin + 1.day
    else
      _begin = Time.now - 1.hour
      _end   = Time.now
    end

    @events = LogBot::Event.all \
      :channel => "##{@channel}",
      :type => :message,
      :created_at.gte => _begin,
      :created_at.lt => _end

    render
  end

  def feed
    only_provides :atom

    @channel = params[:channel]

    now = Time.now
    today = Time.mktime now.year, now.month, now.day
    before = today - Merb::Config[:feed_time_span]

    @events = LogBot::Event.all \
      :channel => "##{@channel}", 
      :created_at.gte => before,
      :created_at.lt => today,
      :type => :message

    @updated = @events.last.created_at

    render
  end
end
