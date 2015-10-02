#!/usr/bin/env ruby

class Refmebot
 require 'Twitter'
 require 'pry'

 WAIT_BEFORE_CALLING = 40 # seconds
 TOTAL_DEMO_TIME = 1000 # seconds



  def initialize
    initial_setup
  end


  # check if there are new mettions
  def get_all_mentions
    @client.mentions_timeline.to_set
  end

  def new_mentions
    new_mentions = get_all_mentions - @tweet_logs
    @tweet_logs << new_mentions unless new_mentions.empty?
    new_mentions
  end

  def process(tweets)
    puts tweets
  end
private

  def setup_connection
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "VUMCVMQ0rToV5vlPTXdKXq2rh"
      config.consumer_secret     = "eE8gRHOiNVKas4g8W3zIxggVNt0XuxHj7SfmDifg32MtDIKoQz"
      config.access_token        = "3837774814-t8fshLYx1goxuaCguEYEQTGiZB666jisfhNhama"
      config.access_token_secret = "Pn6DQOkCq1Hkzf4rerCAZGJ2zLHB8Obavcez9Pm4OhNbE"
    end
  end

  def initial_setup
    setup_connection
    # loading the yaml data
    @tweet_logs = get_all_mentions # store all previous mentions to de database
  end
end


bot = Refmebot.new
initial_time = Time.now

# mentions to the bot so far
puts "All mentions so far:" + bot.get_all_mentions.map {|t| [t.user.screen_name,t.text].join(' ')}.join("\n")

# looping for pooling twitter
while (Time.now - initial_time) < Refmebot::TOTAL_DEMO_TIME
  call_to_action = bot.new_mentions                                     # fetch twitter in search of new mention to the bot
  process call_to_action  unless call_to_action.empty?                  # process the new messages
  sleep(Refmebot::WAIT_BEFORE_CALLING)                                  # delay to respect twitter Rate limits
end

