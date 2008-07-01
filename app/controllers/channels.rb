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
    before = now - Merb::Config[:feed_time_span]

    @events = LogBot::Event.all \
      :channel => "##{@channel}", 
      :created_at.gte => before,
      :created_at.lte => now,
      :type => :message
    render
  end
end
