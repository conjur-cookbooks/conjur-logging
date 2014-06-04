#!/opt/conjur/embedded/bin/ruby

require 'json'
require 'openssl'
require 'base64'

# TODO! example PEN, replace with our own when we get it
PRIVATE_ENTERPRISE_NUMBER = 32473

USER = 'foo'
KEY = 'bar'

# example entry:
# { "msg": " pam_unix(sshd:session): session closed for user ubuntu",
# "rawmsg": "<86>Jun  3 22:47:55 sshd[8987]: pam_unix(sshd:session): session closed for user ubuntu",
# "timereported": "2014-06-03T22:47:55.093314+00:00",
# "hostname": "ip-10-84-255-128",
# "syslogtag": "sshd[8987]:",
# "inputname": "imuxsock",
# "fromhost": "ip-10-84-255-128",
# "fromhost-ip": "127.0.0.1",
# "pri": "86",
# "syslogfacility": "10",
# "syslogseverity": "6",
# "timegenerated": "2014-06-03T22:47:55.093314+00:00",
# "programname": "sshd",
# "protocol-version": "0",
# "structured-data": "-",
# "app-name": "sshd",
# "procid": "8987",
# "msgid": "-",
# "uuid": null,
# "$!": null }
SIGNED_KEYS = %w(
  timereported
  hostname
  pri
  protocol-version
  structured-data
  app-name
  procid
  msgid
  msg
)

STDOUT.sync = true

while entry = gets
  entry = JSON.parse entry
  hmac = OpenSSL::HMAC.new(KEY, OpenSSL::Digest::SHA256.new)
  hmac << USER
  SIGNED_KEYS.each do |key|
    hmac << entry[key] if entry[key]
  end
  sd = entry['structured-data'] || ''
  sd = '' if sd == '-'

  sd += '[sig@%d name="%s" sig="%s"]' % [
    PRIVATE_ENTERPRISE_NUMBER,
    USER, Base64.strict_encode64(hmac.digest)
  ]

  puts JSON.dump('structured-data' => sd)
end
