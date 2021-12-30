
require 'discordrb'
require 'dotenv/load'

class Discord
  attr_accessor :bot

  def initialize
    @bot = Discordrb::Commands::CommandBot.new(token: ENV['TOKEN'] ,client_id: ENV['CLIENT_ID'])
    create_channel
  end

  def start
    puts "起動したわよ"
    
    setting

    @bot.run
  end

  def create_channel
    @bot.event do |event|
      for cate in event.server.categories
        exist = true if cate.name == "score"
      end
      event.server.create_channel("score", type = 4) unless exist
      puts "hi"
    end
  end

  def setting
    bot.message(with_text: "oha") do |event|
      event.respond "kaisi"
    end
  end
end

bot = Discord.new
bot.start