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
    def exec(*args)
      Kernel.exec(store.hash, *args)
    rescue Errno::EACCES
      puts "Not executable: #{args.first}"
    rescue Errno::ENOENT => error
      puts error
    rescue ArgumentError
      puts "redis_vars exec needs a command to run"
    end

    desc "version", "Displays gem version"
    def version
      puts VERSION
    end

    private

    def store
      @store ||= Store.new
    end

    def method_missing(*args)
      if args
        args[0] = args[0].to_s
        exec(*args)
      else
        help
      end
    end

  end
end
