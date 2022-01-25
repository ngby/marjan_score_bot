
require 'discordrb'
require 'dotenv/load'

class Discord
  attr_accessor :bot

  def initialize
    @bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'],client_id: ENV['CLIENT_ID'])
    
  end

  def start
    puts "start"
    
    setting

    bot.run
  end

  def create_channel(event)
    for cate in event.server.categories
      exist = true if cate.name == "score"
    end
    event.server.create_channel("score", type = 4) unless exist
  end

  def setting
    bot.server_create do |event|
      create_channel(event)
    end
    bot.message(with_text: "oha") do |event|
      event.respond "kaisi"
    end
    bot.message(with_text: "des") do |event|
      event.bot.stop
    end
  end
end

bot = Discord.new
bot.start