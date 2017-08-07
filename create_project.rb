require './lib/github'
require './lib/digital_ocean'

name = ARGV[0]
description = ARGV[1]

GitHub.create_repo name description
DigitalOcean.create_droplet name
