require 'cinch'
require 'twitter'

# omajinai
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Twitter.configure do |config|
  config.consumer_key = ""
  config.consumer_secret = ""
  config.oauth_token = ""
  config.oauth_token_secret = ""
end

bot = Cinch::Bot.new do

  configure do |c|
    c.server = "irc.friend-chat.jp"
    c.channels = ["#hoge"]
    c.nick = "hoge"
    c.realname = "hoge"
    c.user = "hoge"
  end

  on :message do |m|
    if /go away/ =~ m.message
      bot.part channel, 'bye'
    end

    str = m.user.nick + " : " + m.message
    str = str.force_encoding("iso-2022-jp").encode!("UTF-8")
    
    pp Twitter.update(str)
  end

end

bot.start
