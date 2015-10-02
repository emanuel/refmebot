#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'refmebot/reference_reader'
require 'refmebot'


bot = Refmebot.new
initial_time = Time.now

# mentions to the bot so far
puts "All mentions so far:"
puts bot.get_all_mentions.map {|t| [t.user.screen_name,t.text].join(' ')}.join("\n")

# puts  bot.find "978-0552125550 MLA"
#looping for pooling twitter
while (Time.now - initial_time) < Refmebot::TOTAL_DEMO_TIME
  call_to_action = bot.new_mentions                                     # fetch twitter in search of new mention to the bot
  bot.process_new_tweets call_to_action unless call_to_action.empty?                  # process the new messages
  sleep(Refmebot::WAIT_BEFORE_CALLING)                                  # delay to respect twitter Rate limits
end

