require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Merb::ChannelsHelper do
  include Merb::ChannelsHelper

  describe "#linkify_uris" do
    it "should linkify a host only url" do
      linkify_uris("http://one.two.com").should == '<a href="http://one.two.com">http://one.two.com</a>'
      linkify_uris("http://one.two.com/").
        should == '<a href="http://one.two.com/">http://one.two.com/</a>'
    end

    it "should linkify a url with subdirs" do
      linkify_uris("http://one.two.com/something/else").
        should == '<a href="http://one.two.com/something/else">http://one.two.com/something/else</a>'
      linkify_uris("http://one.two.com/something/else/").
        should == '<a href="http://one.two.com/something/else/">http://one.two.com/something/else/</a>'
    end

    it "should not include final punctuation in the links" do
      linkify_uris("http://one.two.com/something/else.").
        should == '<a href="http://one.two.com/something/else">http://one.two.com/something/else</a>.'
      linkify_uris("http://one.two.com/something/else/.").
        should == '<a href="http://one.two.com/something/else/">http://one.two.com/something/else/</a>.'
    end

    it "should include punctuation in the links, when it belongs to the url" do
      linkify_uris("http://one.two.com/something/else.html").
        should == '<a href="http://one.two.com/something/else.html">http://one.two.com/something/else.html</a>'
    end

    it "should not linkify the surroundings" do
      linkify_uris("yadda yadda http://one.two.com/something/else.html, yadda").
        should == 'yadda yadda <a href="http://one.two.com/something/else.html">http://one.two.com/something/else.html</a>, yadda'
    end

    it "should linkify parenthesized uris correctly" do
      linkify_uris("(http://one.two.com/something/else.html)").
        should == '(<a href="http://one.two.com/something/else.html">http://one.two.com/something/else.html</a>)'
      linkify_uris("(http://one.two.com/something/else.html/)").
        should == '(<a href="http://one.two.com/something/else.html/">http://one.two.com/something/else.html/</a>)'
    end
  end
end
