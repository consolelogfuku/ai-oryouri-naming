class LoadingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "loading_channel_#{ip_address}" # ip_addressはconnectionで定義した識別子
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
