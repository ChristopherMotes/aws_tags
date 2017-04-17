# Your ec2 instance's AIM role must have at least AmazonEC2ReadOnlyAccess. 
# DO NOT use keys. Eventually, I'll error trap for this.
require 'open3'
ENV['PATH'] = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/opt/puppetlabs/bin'
Facter.add(:aws_tags) do
	setcode do
		INSTANCE_ID_DOC = Facter.value(:"aws_dynamic_instance_id_doc")
                REGION = INSTANCE_ID_DOC['region']
		tags_hash =  {}
		RESOURCEID = `curl  -s http://169.254.169.254/latest/meta-data/instance-id`
		ENV['AWS_DEFAULT_REGION'] = REGION
		cmd = "aws ec2 describe-tags  --output text --filter \"Name=resource-id,Values=#{RESOURCEID}\" "
		Open3.popen3(cmd) do |stdin, stdout, stderr, status, thread|
			while line = stdout.gets
				split = line.split
				tags_hash[split[1]] = split[4]
			end
		end
		tags_hash
	end
end
