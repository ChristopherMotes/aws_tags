#!/opt/puppetlabs/puppet/bin/ruby 
require 'open3'
RESOURCEID = `curl  -s http://169.254.169.254/latest/meta-data/instance-id`
#cmd = "ec2-describe-tags --filter \"resource-id=#{RESOURCEID}\""
cmd = "/usr/local/bin/aws ec2 describe-tags  --region us-east-1 --output text --filter \"Name=resource-id,Values=#{RESOURCEID}\" "
Open3.popen3(cmd) do |stdin, stdout, stderr, status, thread|
		print stdout.gets
	while line = stdout.gets
		split = line.split
		print 'aws_' + split[1] + '=' + split[4] + "\n"
	end
end
