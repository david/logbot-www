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

    @events = LogBot::Event.all \
      :channel => "##{@channel}", 
      :created_at.lte => Time.now,
      :type => :message

    @events.inspect
    render
  end
end
