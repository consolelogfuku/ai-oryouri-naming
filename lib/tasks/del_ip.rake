namespace :del_ip do
  desc 'ipアドレスを削除する'
  task del_ip: :environment do
    REDIS.keys('ip:*').each { |ip| REDIS.del(ip) } # 接頭辞「ip:」がついたkeyを削除
  end
end
# rake del_ip:del_ip                         # ipアドレスを削除する