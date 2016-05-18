#!/usr/bin/ruby 
require 'open3'
RESOURCEID = `curl  -s http://169.254.169.254/latest/meta-data/instance-id`
cmd = "ec2-describe-tags --filter \"resource-id=#{RESOURCEID}\""
Open3.popen3(cmd) do |stdin, stdout, stderr, status, thread|
	puts 'data' + stdout.read
end