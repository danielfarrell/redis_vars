$:.unshift File.expand_path("../lib", __FILE__)
require "redis_vars/version"

Gem::Specification.new do |gem|
  gem.name     = "redis_vars"
  gem.version  = RedisVars::VERSION

  gem.author   = "Daniel Farrell"
  gem.email    = "danielfarrell76@gmail.com"
  gem.homepage = "http://github.com/danielfarrell/redis_vars"
  gem.summary  = "Environment variable handling for teams following 12 Factor/Heroku pattern"

  gem.description = gem.summary

  gem.executables = "redis_vars"
  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|lib/)} }
  gem.files << "man/redis_vars.1"

  gem.add_dependency 'thor', '>= 0.13.6'
  gem.add_dependency 'redis'

end
