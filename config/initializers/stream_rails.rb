require 'stream_rails'

StreamRails.configure do |config|
  config.api_key     = ENV['STREAM_KEY']
  config.api_secret  = ENV['STREAM_SECRET']
  config.timeout     = 30                # Optional, defaults to 3
  config.location    = 'us-west'         # Optional, defaults to 'us-east'
  # If you use custom feed names, e.g.: timeline_flat, timeline_aggregated,
  # use this, otherwise omit:
  config.news_feeds = {
    venue: "venue",
    wine: "wine",
    flat: "user"
  }
  # Point to the notifications feed group providing the name, omit if you don't
  # have a notifications feed
  # config.notification_feed = "notification"
end

# watchout for id collisions
# three activity data:
# - actor, object, verb, time and foreign_id (can be the same as object)
# - to field in activity references other feed ids
