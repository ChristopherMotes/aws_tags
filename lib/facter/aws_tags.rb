# Your ec2 instance's AIM role must have at least AmazonEC2ReadOnlyAccess. 
# DO NOT use keys. Eventually, I'll error trap for this.
require 'open3'
Facter.add(:aws_tags) do
	setcode do
		tags_hash =  {}
		RESOURCEID = `curl  -s http://169.254.169.254/latest/meta-data/instance-id`
#		cmd = "ec2-describe-tags --filter \"resource-id=#{RESOURCEID}\""
		cmd = "/usr/local/bin/aws ec2 describe-tags  --region us-east-1 --output text --filter \"Name=resource-id,Values=#{RESOURCEID}\" "
		Open3.popen3(cmd) do |stdin, stdout, stderr, status, thread|
			while line = stdout.gets
				split = line.split
				tags_hash[split[1]] = split[4]
			end
		end
		tags_hash
	end
end
