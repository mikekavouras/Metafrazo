# Metafrazo



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metafrazo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metafrazo

## Configuration
```ruby
# basic

Metafrazo.configure do |config|
  config.usernames = ["@mikekavouras"] # who gets notified?
  config.token = "4567829390823jr32rj" # access token
  config.path = "some/path/" # Path or file to watch. Must be relative to the root directory
end
```

```ruby
# advanced

Metafrazo.configure do |config|
  config.usernames = ["@mikekavouras"]
  config.token = "384759828923rji923j23"
  config.repos = {
    "username/reponame" => {
      base_branch: "develop",
      path: "some/path"
    },
    "username/other_reponame" => {
      path: "other/path/somewhere"
    }
  }
end
```

By default, Metafrazo assumes your base branch (`base_branch`) is `master`.

## Usage
```ruby
Metafrazo.run(payload) # payload = json from github webook
```
returns `true` if there are changes to the specified paths

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikekavouras/metafrazo.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

