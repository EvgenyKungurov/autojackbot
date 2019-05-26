require 'telegram/bot'

token = ENV['TELEGRAM_BOT_TOKEN']

conn = Faraday.new(:url => 'https://1wanl.xyz/')
live = 'bets/live'

loop do
  begin
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        Thread.start do
          case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
          when '/stop'
            bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
          when '/live'
            response = conn.get live
            bot.api.send_message(chat_id: message.chat.id, text: response.body)
          end
        end
      end
    end
  rescue => e
    puts e.message
  end
end