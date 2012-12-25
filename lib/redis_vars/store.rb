require "redis_vars/config"
require "redis"

module RedisVars
  class Store

    def add(key, value)
      redis.hset app_key, key.upcase, value
    end

    def remove(key)
      redis.hdel app_key, key.upcase
    end

    def hash
      redis.hgetall(app_key)
    end

    def list
      map {|key, val| "#{key.upcase}=#{val}"}.join("\n")
    end

    def export
      map {|key, val| "export #{key.upcase}=#{val}"}.join("\n")
    end

    def execute
      map {|key, val| "#{key.upcase}=#{val}"}.join(" ")
    end

    private

    def map(&block)
      hash.map &block
    end

    def url
      config.url
    end

    def app_key
      config.app_key
    end

    def redis
      @redis ||= Redis.new(:url => url)
    end

    def config
      @config ||= Config.new
    end

  end
end
