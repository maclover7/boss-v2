require 'slack-ruby-bot'

if ENV["RACK_ENV"] != "production"
  require 'pry'
end

module Bot

  REDIS_CONN = Redis.new(:url => ENV["REDIS_URL"] || "redis://localhost:6379")

  class App < SlackRubyBot::App
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
