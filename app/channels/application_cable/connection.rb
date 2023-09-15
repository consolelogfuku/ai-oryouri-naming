module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # ip_address という識別子を使って、接続を一意に識別する(ip_addressという値は、チャネル内で使用可能)
    identified_by :ip_address

    # connectメソッドはWebSocket接続時に自動的に呼び出される特別なメソッド(初期化)
    def connect
      self.ip_address = request.remote_ip
    end
  end
end
