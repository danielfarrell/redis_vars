require "redis_vars/version"
require "redis_vars/store"
require "thor"

module RedisVars
  class CLI < Thor

    desc "add KEY VALUE", "Add a new env var"
    def add(key, value)
      store.add key, value
    end

    desc "remove KEY", "Remove a env var"
    def remove(key)
      store.remove key
    end

    desc "list", "List the env vars"
    def list
      puts store.list
    end

    desc "export", "Export env vars"
    def export
      puts store.export
    end

    desc "exec", "Runs a command with the stored env vars"
    def exec(*commands)
      Kernel.exec "/bin/sh -c '#{store.exec} #{commands.join(' ')}'"
    end

    desc "version", "Displays gem version"
    def version
      puts VERSION
    end

    private

    def store
      @store ||= Store.new
    end

  end
end
