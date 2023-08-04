class ApplicationMailer < ActionMailer::Base
  default from: "ai.oryouri.naming@gmail.com" # 送信元アドレス
  layout "mailer"
end
