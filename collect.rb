require 'json'

w = File.open('img.md', 'w')
w.print "# `3dep` collection\n"

WAIT = 30
json = JSON.parse(gets)

count = 0
json['links'].each {|entry|
  next unless entry['rel'] == 'item'
  count += 1
  url =  'https://viewer.copc.io/?resources=' +
    JSON.parse(`curl --silent #{entry['href']}`)['assets']['ept.json']['href']
  fn = url.split('/')[-2]
  img_path = "img/#{fn}.jpg"
  cmd = <<-EOS
npx playwright screenshot --wait-for-timeout=#{WAIT * 1000} \
"#{url}" #{img_path}
  EOS
  w.print <<-EOS
## #{fn}
[![#{fn}](#{img_path})](#{url})

  EOS
  w.flush
  print "#{count}: #{cmd}"
  system cmd
}

