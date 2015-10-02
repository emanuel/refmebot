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

  def process_new_tweets(tweets)
    tweets.each do |tweet|
    # @client.mentions_timeline.each do |tweet|
      self.parse tweet
    end
  end

# Class methods

  def self.parse(tweet)
    handle,key, style = tweet.text.split
    puts handle
    puts key
    puts style
  end

  def find(key)
    @database[key]
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
    @database =  ReferenceReader.new.get_reference_map_from
    @tweet_logs = get_all_mentions # store all previous mentions to de database
  end
end
