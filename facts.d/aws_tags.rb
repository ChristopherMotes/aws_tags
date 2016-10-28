#!/opt/puppetlabs/puppet/bin/ruby 
require 'open3'
ENV['PATH'] = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/opt/puppetlabs/bin'
RESOURCEID = `curl  -s http://169.254.169.254/latest/meta-data/instance-id`
#cmd = "ec2-describe-tags --filter \"resource-id=#{RESOURCEID}\""
cmd = "aws ec2 describe-tags  --region us-east-1 --output text --filter \"Name=resource-id,Values=#{RESOURCEID}\" "
Open3.popen3(cmd) do |stdin, stdout, stderr, status, thread|
	while line = stdout.gets
		split = line.split
		print 'aws_' + split[1] + '=' + split[4] + "\n"
	end
end
