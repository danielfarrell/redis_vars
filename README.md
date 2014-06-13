# RedisVars

Manage environment variables for development teams follows the 12 Factors/Heroku pattern. You will need a shared redis server for your team. I suggest you share a RedisToGo free plan if you are distributed, or use your development redis server if you have one and would prefer that.

## Install

    gem install redis_vars

Set REDIS_VARS_URL for your shell(.profile/.bash_profile/.zprofile/etc):

    export REDIS_VARS_URL=redis://password@hostname:port/db

Set APP_KEY to your application (will default to pwd):

    export APP_KEY=my_application_name

## Managing

It uses your project directory name as the key, so use consistently named folders for your team.  Switch into your project directory and run any of the following commands:

    redis_vars add TEST_KEY value
    redis_vars list
    redis_vars remove TEST_KEY

Every key name is made uppercase, so feel free to be lazy and use all lowercase keys in your management.

You can override the key used with an enviroment variable if you want to manage from a different folder:

    APP_KEY=different_app redis_vars list

## Developing

There are a couple of different ways I envision this being used: on execution and in configuation:

### On Execution

As of version 0.7.x there is an exec command to run a command with the environment variables you have in the store. As of 0.8.0, exec is the assumed command if you pass anything unknown.

Here is an example:

    redis_vars exec unicorn_rails -c config/unicorn.rb

or

    redis_vars unicorn_rails -c config/unicorn.rb

It will set the environment variables you have stored and then execute the command that you passed.

This is useful for running command line programs(binstubs for example) and executing services without having to worry about loading the environment variables.

### Configuration

This allows you to export a list of the variables you have stored to a file you use in development. There seems to be the two different formats used places, with and without requiring export.  The list command is for without export, and export includes the export. Here are examples if that makes now sense:

Forman:

    redis_vars list > .env

rbenv(with rbenv-vars plugin):

    redis_vars list > .rbenv-vars

Pow:

    redis_vars export > .powenv

## Inspiration

I took a lot of inspiration from [redis-env](https://github.com/brynary/redis-env), but wanted something in a language I knew and that would hit my different use cases(export, load in code, etc).

## Authors

#### Created and maintained by
Daniel Farrell

## License

MIT
