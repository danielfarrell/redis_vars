# RedisVars

Manage environment variables for development teams follows the 12 Factors/Heroku pattern. You will need a shared redis server for your team. I suggest you share a RedisToGo free plan if you are distributed, or use your development redis server if you have one and would prefer that.

## Install

    gem install redis_vars

Set REDIS_VARS_URL for your shell(.profile/.bash_profile/.zprofile/etc):

    export REDIS_VARS_URL=redis://password@hostname:port/db

## Managing

It uses your project directory name as the key, so use consistently named folders for your team.  Switch into your project directory and run any of the following commands:

    redis_vars add TEST_KEY value
    redis_vars list
    redis_vars remove TEST_KEY

Every key name is made uppercase, so feel free to be lazy and use all lowercase keys in your management.

You can override the key used with an enviroment variable if you want to manage from a different folder:

    APP_KEY=different_app redis_vars list

## Developing

There are a few different ways I envision this being used: in configuation, on execution, and in code. Let's start with configuration:

### Configuration

This allows you to export a list of the variables you have stored to a file you use in development. There seems to be the two different formats used places, with and without requiring export.  The list command is for without export, and export includes the export. Here are examples if that makes now sense:

Forman:

    redis_vars list > .env

rbenv(with rbenv-vars plugin):

    redis_vars list > .rbenv-vars

Pow:

    redis_vars export > .powenv

### On Execution

As of version 0.7.0 there is an execute command to run a command with the environment variables you have in the store.

Here is an example:

    redis_vars execute unicorn_rails
    
If you had a single variable store of DEFAULT_USER with a value of daniel then it should execute the following:

    DEFAULT_USER=daniel unicorn_rails

I envision this being useful for running command line programs or even executing services.

### In Code

You can have it load in the environment variables automatically in a ruby/rails application with this method.

Gemfile:

    group :development do
      gem 'redis_vars'
    end

config/environments/development.rb:

    RedisVars.load

Note that if you env vars are already set it will not overwrite them. This allows you to do this method in combination with using the non-invasive method to override what is stored in redis.

## Authors

#### Created and maintained by
Daniel Farrell

## License

MIT
