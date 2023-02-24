task :default do
  sh <<-EOS
curl --silent https://usgs-lidar-stac.s3-us-west-2.amazonaws.com/ept/catalog.json |\
ruby collect.rb
  EOS
end
