
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
    category = serch_category("score")
    event.server.create_channel("score", type = 4) unless category.nil?
    serch_channel("成績")
    event.server.create_channel("score", type = 0) unless channel.nil?
  end

  def serch_category(name)
    for cate in event.server.categories
      category = cate if cate.name == name
    end
  end

  def serch_channel(name)
    for chan in event.server.text_channels
      channel = chan if chan.name == name
    end
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