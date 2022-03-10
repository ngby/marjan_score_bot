
require 'discordrb'
require 'dotenv/load'
require "net/http"

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

  def set_bot_channel(event)
    category = search_bot_category("score",event)
    if category.nil?
      event.server.create_channel("score", type = 4)
      category = search_bot_category("score",event)
    end

    channel = search_bot_channel("成績",event)
    if channel.nil?
      event.server.create_channel("成績", type = 0, parent: category, reason:"ここにスクショを貼ってくれ!") 
      channel = search_bot_channel("成績",event)
    end

    return category  , channel 
  end

  def search_bot_category(name,event)
    for cate in event.server.categories
      category = cate if cate.name == name
    end
    return category
  end

  def search_bot_channel(name,event)
    for chan in event.server.text_channels
      channel = chan if chan.name == name
    end
    return channel
  end

  def get_score_image(event)
    arr = event.message.attachments
    params = { title: arr[0].url }
    uri = URI.parse("http://127.0.0.1:8080/api/v1/scores.json")
    response = Net::HTTP.post_form(uri, params)

    p response.code # status code
    p response.body # response body
  end


  def setting
    bot.server_create do |event|
      set_bot_channel(event)
    end
    
    bot.message() do |event|
      bot_category , bot_channel = set_bot_channel(event)
      #親カテゴリとチャンネルが一緒なら発火
      if event.channel.parent == bot_category && event.channel == bot_channel
        get_score_image(event)
      end
    end

    bot.message(with_text: "oha") do |event|
      event.respond "you"
    end
    bot.message(with_text: "des") do |event|
      event.respond "bye"
      event.bot.stop
    end
  end
end


bot = Discord.new
bot.start

