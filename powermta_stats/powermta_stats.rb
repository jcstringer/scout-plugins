%w( nokogiri open-uri ).each { |f| require f }

class PowermtaStats < Scout::Plugin
  def build_report
    uri = option(:uri) || "http://127.0.0.1:8080/"
    status = Nokogiri::XML(open(uri+'status?format=xml'))
    report({
      "Out: Recipients/min" => status.xpath('//rsp/data/status/traffic/lastMin/out/rcp').children.first.content,
      "Out: Messages/min" => status.xpath('//rsp/data/status/traffic/lastMin/out/msg').children.first.content,
      "Out: KB/min" => status.xpath('//rsp/data/status/traffic/lastMin/out/kb').children.first.content,
      "Out: SMTP Connections/min" => status.xpath('//rsp/data/status/conn/smtpOut/cur').children.first.content,
      "In: Recipients/min" => status.xpath('//rsp/data/status/traffic/lastMin/in/rcp').children.first.content,
      "In: Messages/min" => status.xpath('//rsp/data/status/traffic/lastMin/in/msg').children.first.content,
      "In: KB/min" => status.xpath('//rsp/data/status/traffic/lastMin/in/kb').children.first.content,
      "In: SMTP Connections/min" => status.xpath('//rsp/data/status/conn/smtpIn/cur').children.first.content,
      "Queued Recpipents" => status.xpath('//rsp/data/status/queue/smtp/rcp').children.first.content,
      "Queued Domains" => status.xpath('//rsp/data/status/queue/smtp/dom').children.first.content,
      "Queued KB" => status.xpath('//rsp/data/status/queue/smtp/kb').children.first.content,
      "Spool Files" => status.xpath('//rsp/data/status/spool/files/total').children.first.content,
      "Spool Initialization" => status.xpath('//rsp/data/status/spool/initPct').children.first.content
    })
  end
end
