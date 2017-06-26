# S3imageoptim

S3imageoptim is a command line utility to compress images in Amazon S3.

## Requirements

This tools requires that you have `s3cmd` installed and working, as well as read and write permissions in the target S3 bucket.
You don't need to install compression tools in your machine because we will be using prebuilt binaries 🕺.

## Installation

`gem install s3imageoptim`

## Usage

`s3imageoptim bucket-or-path-in-s3cmd-format`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake s3_server` to run a fake S3 server on your machine (this will overwrite your ~/.s3cfg config, but will try to restore it after you stop the server with CTRL-C). Then run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simplelogica/s3imageoptim. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
