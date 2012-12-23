require "redis_vars/version"
require "redis_vars/store"

module RedisVars
  def self.load
    Store.new.hash.each { |key, value| ENV[key.upcase] = value unless ENV[key.upcase] }
  end
end
