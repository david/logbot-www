require 'logbot/event'

class Channels < Application
  
  def index
    render
  end

  def show
    render
  end

  def feed
    only_provides :xml
    @channel = params[:channel]

    now = Time.now
    today = Time.mktime now.year, now.month, now.day
    before = today - Merb::Config[:feed_time_span]

    @events = LogBot::Event.all \
      :channel => "##{@channel}", 
      :created_at.gte => before,
      :created_at.lte => today,
      :type => :message

    @updated = @events.last.created_at
    render
  end
end
