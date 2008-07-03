require 'logbot/event'

class Channels < Application
  
  def index
    render
  end

  def show
    @channel = params[:channel]

    now     = Time.mktime 2008, 6, 30
    today   = Time.mktime now.year, now.month, now.day
    @events = LogBot::Event.all \
        :channel => "##{@channel}", 
        :created_at.gte => today,
        :type => :message

    max_nick_size = @events.inject(0) { |max, e| max > e.nick.length ? max : e.nick.length }

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
      :created_at.lte => today,
      :type => :message

    @updated = @events.last.created_at

    render
  end
end
