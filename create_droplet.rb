require './lib/digital_ocean'

name = ARGV[0]

DigitalOcean.create_droplet name
