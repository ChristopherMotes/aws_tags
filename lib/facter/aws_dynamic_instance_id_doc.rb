require 'net/http'
require 'uri'
require 'json'

Facter.add(:aws_dynamic_instance_id_doc) do
	setcode do
		uri = URI.parse("http://169.254.169.254/latest/dynamic/instance-identity/document")
		response = Net::HTTP.get_response(uri)
		JSON.parse(response.body)
	end
end
