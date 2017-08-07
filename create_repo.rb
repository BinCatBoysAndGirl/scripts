require './lib/github'

name = ARGV[0]
description = ARGV[1]

GitHub.create_repo name, description
