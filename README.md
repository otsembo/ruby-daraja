# Ruby::Daraja

`Ruby::Daraja` is a Ruby wrapper for the [Safaricom Daraja API](https://developer.safaricom.co.ke). It provides a simple interface to the API endpoints and allows for smooth setup in `Ruby on Rails` applications or any other Ruby application.

## Installation

**IMPORTANT**: This gem is not yet released to [rubygems.org](https://rubygems.org). The instructions below are for when the gem is released.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-daraja

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-daraja

# Usage
With `ruby-daraja` you can easily make requests to the Safaricom Daraja API. The DSL is simple and easy to use. The DSL is divided into [two] parts:

1. [Configuration](#configuration)
2. [Requests](#requests)

### Configuration
In order to get started with the DSL, you need to configure the gem with your credentials. 

1. The gem uses environment variables to store the API credentials. The following environment variables are required:
    ```shell
    CONSUMER_KEY='daraja consumer key here'
    CONSUMER_SECRET='daraja consumer secret here'
    ```
2. Create a new instance of the `Ruby::Daraja::DarajaAuthProvider` class. This class will be used to create an access token for all the requests to the [Daraja](https://developer.safaricom.co.ke) API.
    ```ruby
    require 'ruby-daraja'
    # Create a new instance of the DarajaAuthProvider class
    auth_provider = DarajaAuthProvider.create
    ```
   
    <div style="text-align: center;">or</div>

    ```ruby
    require 'ruby-daraja'
    # Create a new instance of the DarajaAuthProvider class without environment variables
    auth_provider = DarajaAuthProvider.create(
      key: 'consumer key here',
      secret: 'consumer secret here'
   )
    ```
3. You can also have a toggle between the sandbox and production environments. The default environment is the sandbox environment. To change the environment, you can pass the `env` parameter to the `create` method. The `env` parameter can either be `:sandbox` or `:production`.
    ```ruby
    require 'ruby-daraja'
    # Create a new instance of the DarajaAuthProvider class
    auth_provider = DarajaAuthProvider.create(is_sandbox: true)
    ```
   **NB:** The `is_sandbox` parameter is `true` by default when using the `create` method.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/otsembo/ruby-daraja. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ruby-daraja/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby::Daraja project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-daraja/blob/master/CODE_OF_CONDUCT.md).
