#!/usr/bin/env ruby

require 'Twitter'

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "VUMCVMQ0rToV5vlPTXdKXq2rh"
    config.consumer_secret     = "eE8gRHOiNVKas4g8W3zIxggVNt0XuxHj7SfmDifg32MtDIKoQz"
    config.access_token        = "3837774814-t8fshLYx1goxuaCguEYEQTGiZB666jisfhNhama"
    config.access_token_secret = "Pn6DQOkCq1Hkzf4rerCAZGJ2zLHB8Obavcez9Pm4OhNbE"
  end

# client.update("Seccond Tweet!")

# Search for the hashtag "#hashtag". Grab the last 100 tweets
client.search("#refme").take(100).each do |tweet|
  # Push all the tweets collected one by one to the default output (command-line, usually)
  puts tweet.text
end