require "rest-client"
require "json"


name = ARGV[0]

def token
  path = Dir.home + "/.keys/digital-ocean"
  File.read(path).chomp
end

def ssh_key
  path = Dir.home + "/.keys/digital-ocean-shh"
  File.read(path).chomp
end

def endpoint
  "https://api.digitalocean.com/v2"
end

def payload(name) 
	{
	name: name,
	region: "lon1",
	size: "512mb",
	image: "docker-16-04",
	ssh_keys: [ssh_key],
	backups: false,
	private_networking: true
	}.to_json
end

def list_images
	RestClient.get(
		"#{endpoint}/images?type=application&per_page=50",
		{
			"Content-Type" => "application/json",
			"Authorization" => "Bearer #{token}"
		}
	)
end

def create_droplet(name)
	begin
		RestClient.post(
			"#{endpoint}/droplets",
			payload(name),
			{
				"Content-Type" => "application/json",
				"Authorization" => "Bearer #{token}"
			}
		)
	rescue RestClient::ExceptionWithResponse => e
		e.response
	end
	puts "Created new droplet: #{name}"

end

create_droplet(name)