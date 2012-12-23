require "rubygems"
require "mocha/api"
require "rspec"

def redis_vars(args)
  capture_stdout do
    begin
      RedisVars::CLI.start(args.split(" "))
    rescue SystemExit
    end
  end
end

def capture_stdout
  old_stdout = $stdout.dup
  rd, wr = IO.method(:pipe).arity.zero? ? IO.pipe : IO.pipe("BINARY")
  $stdout = wr
  yield
  wr.close
  rd.read
ensure
  $stdout = old_stdout
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.color_enabled = true
  config.mock_framework = :mocha

  config.order = 'random'
end
