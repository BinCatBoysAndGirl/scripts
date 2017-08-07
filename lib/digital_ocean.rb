require "rest-client"
require "json"

module DigitalOcean
  ENDPOINT = "https://api.digitalocean.com/v2"

  def self.read_token
    path = Dir.home + "/.keys/digital-ocean"
    File.read(path).chomp
  end

  def self.read_ssh_key
    path = Dir.home + "/.keys/digital-ocean-shh"
    File.read(path).chomp
  end

  def DigitalOcean.create_droplet(name)
    begin
      RestClient.post(
	"#{endpoint}/droplets",
        {name: name,
         region: "lon1",
         size: "512mb",
         image: "docker-16-04",
         ssh_keys: [read_ssh_key],
         backups: false,
         private_networking: true}.to_json,
	{"Content-Type" => "application/json",
	 "Authorization" => "Bearer #{token}"})
      
      puts "Created new droplet: #{name}"
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end
end
