require "rest-client"
require "json"

module GitHub
  ENDPOINT = "https://api.github.com"
  ORG_NAME = "BinCatBoysAndGirl"

  def self.read_token
    path = Dir.home + "/.keys/github"
    File.read(path).chomp
  end

  def self.create_repo(name, description = "")
    begin
      RestClient.post(
        "#{ENDPOINT}/orgs/#{ORG_NAME}/repos",
        {name: name, description: description}.to_json,
        {:Authorization => "token #{read_token}"})

      puts "Created new github repo: #{name}"
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end
end
