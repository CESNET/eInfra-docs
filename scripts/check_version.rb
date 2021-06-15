require 'faraday'
require 'json'

#print ARGV[0].downcase
puts "Checking the ver for #{ARGV[0]}"

response = Faraday.get "https://release-monitoring.org/api/projects/?pattern=#{ARGV[0].downcase}"

fedora_j = JSON.parse( response.body )['projects']
fedora = fedora_j.select { |h| h['name'] == ARGV[0].downcase }.first['version']

response = Faraday.get "https://docs.it4i.cz/modules-matrix.json"

it4i = JSON.parse( response.body )['projects'][ARGV[0]]
it4i_short = it4i.split('-')[0]
puts "IT4Innovations: #{it4i_short} (#{it4i})"
puts "Upstream      : #{fedora}"

if it4i_short.eql? fedora
  puts "Identical"
else

end
