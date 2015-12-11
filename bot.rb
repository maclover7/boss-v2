require 'cloudinary'
require 'redis'
require 'slack-ruby-bot'

if ENV["RACK_ENV"] != "production"
  require 'pry'
end

module Bot

  REDIS_CONN = Redis.new(:url => ENV["REDIS_URL"] || "redis://localhost:6379")

  class App < SlackRubyBot::App
  end

  class PicAdd < SlackRubyBot::Commands::Base
    command 'pic add'

    def self.call(client, data, match)
      raw = match.to_a[3].split(": ")
      keyword = raw[0]
      url = raw[1].delete!('<').delete!('>')

      cloudinary = Cloudinary::Uploader.upload(url)
      photo_url = cloudinary['secure_url']
      REDIS_CONN.sadd(keyword, [photo_url])

      keyword_total = REDIS_CONN.smembers(keyword).count
      send_message(client, data.channel, "Photo added successfully to #{keyword}, 
                   bringing the total number of pictures for #{keyword} to #{keyword_total}.")
    end
  end

  class PicMe < SlackRubyBot::Commands::Base
    command 'pic me'

    def self.call(client, data, match)
      keyword = match.to_a[3]
      photo = REDIS_CONN.smembers(keyword).sample
      send_message(client, data.channel, photo)
    end
  end

  class Ping < SlackRubyBot::Commands::Base
    command 'ping'

    def self.call(client, data, _match)
      client.message(text: 'pong', channel: data.channel)
    end
  end

  class Gif < SlackRubyBot::Commands::Base
    command 'gif me'

    def self.call(client, data, match)
      keyword = match.to_a[3]
      send_gif(client, data.channel, keyword)
    end
  end

  class Swanson < SlackRubyBot::Commands::Base
    command 'swanson me'

    def self.call(client, data, _match)
      send_gif(client, data.channel, 'swanson')
    end
  end
end
