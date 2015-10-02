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
      parse tweet
    end
  end

  def parse(tweet)
    handle,key, style = tweet.text.split
    compoound_key = key + style
    msg = find compoound_key                    # get the right reference form the database
    if msg
      tweet_back(tweet,msg)
    else
      tweet_back(tweet,"Sorry We coulnd't find the reference you're looking for")
    end
  end

  def tweet_back(tweet,msg)
    user_handler = tweet.user.screen_name
    puts user_handler
    # post the mesage to the user of the tweet
    @client.update(user_handler + ' ' + msg) if user_handler
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
