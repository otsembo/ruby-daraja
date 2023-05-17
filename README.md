# Ruby::Daraja

`Ruby::Daraja` is a Ruby wrapper for the [Safaricom Daraja API](https://developer.safaricom.co.ke). It provides a simple interface to the API endpoints and allows for smooth setup in `Ruby on Rails` applications or any other Ruby application.

## Installation

**IMPORTANT**: This gem is not yet released to [rubygems.org](https://rubygems.org). The instructions below are for when the gem is released.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ruby-daraja

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ruby-daraja

# Usage
With `ruby-daraja` you can easily make requests to the Safaricom Daraja API. The DSL is simple and easy to use. The DSL is divided into two parts:

1. [Configuration](#configuration)
2. [Requests](#requests)

## Configuration
In order to get started with the DSL, you need to configure the gem with your credentials. 

There are two ways to get started with `ruby-daraja`:
1. [Development](#development)
2. [Production](#production)


### Development
This is a quick-start mode for the gem. It is meant to get you up and running quickly. It is not recommended for `production` applications. To get started with the gem in `development` mode, follow the steps below:

1. Setup environment variables needed for your application. The environment variables needed are:
    ```shell
   CONSUMER_KEY='daraja consumer key here'
   CONSUMER_SECRET='daraja consumer secret here'
   VALIDATION_URL='C2B Validation URL'
   CONFIRMATION_URL='C2B Confirmation URL'
   IS_SANDBOX='boolean indicating whether you are in sandbox or production'
   SHORT_CODE='daraja (paybill /till number) short code here'
    ```
2. You will need a `Ruby::Daraja::Pay::AppConfig` instance. This instance is used to configure the application. It is created as follows:
    ```ruby
    require 'ruby-daraja'
   
    app_config = Ruby::Daraja::AppUtils._app_config
    ```

### Production
`TODO: Add instructions for production mode`

## Requests

1. Register C2B URLs
   ```ruby
   require 'ruby-daraja'
   
   config = Ruby::Daraja::AppUtils._app_config
   responses = config.register_urls # array of JSON responses from Safaricom Daraja API
   ```

2. 



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/otsembo/ruby-daraja. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ruby-daraja/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruby::Daraja project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-daraja/blob/master/CODE_OF_CONDUCT.md).
