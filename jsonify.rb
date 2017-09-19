#!/usr/bin/env ruby

require 'json'

puts JSON.pretty_generate(

$stdin.read.split("\n").map do |line|
	name, sha1 = line.split(" sha1=")
	iaas = name.match(/\d+\.\d+-([a-z]+)-/)[1]
	url = "https://s3.amazonaws.com/bosh-core-stemcells/#{iaas}/#{name}"
	foo = `curl -s -X HEAD -I #{url}`
	puts url
	{
		"Key" => "#{iaas}/#{name}",
	  "ETag" => foo.match(/ETag: ("[a-z0-9\-]+")/)[1],
	  "SHA1" => sha1,
	  "Size" => foo.match(/Content\-Length: (\d+)/)[1].to_i,
	  "LastModified" => "2017-09-19T21:52:10.000Z",
	  "URL" => url
	}
end

)
