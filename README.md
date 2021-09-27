# Plutto Ruby SDK

[![Gem Version](https://badge.fury.io/rb/plutto-ruby.svg)](https://badge.fury.io/rb/plutto-ruby)
[![CircleCI](https://circleci.com/gh/platanus/plutto-ruby.svg?style=shield)](https://app.circleci.com/pipelines/github/platanus/plutto-ruby)

This gem will help you easily integrate Plutto API to your software, making your developer life a little bit more enjoyable.

## Installation

```bash
$ gem install plutto-ruby
```

Or add to your Gemfile:

```ruby
gem "plutto-ruby"
```

```bash
bundle install
```

## Usage

TODO

## Testing

To run the specs you need to execute, **in the root path of the gem**, the following command:

```bash
bundle exec guard
```

You need to put **all your tests** in the `/my_gem/spec/` directory.

## Publishing

On master/main branch...

1. Change `VERSION` in `lib/plutto-ruby/version.rb`.
2. Change `Unreleased` title to current version in `CHANGELOG.md`.
3. Run `bundle install`.
4. Commit new release. For example: `Releasing v0.1.0`.
5. Create tag. For example: `git tag v0.1.0`.
6. Push tag. For example: `git push origin v0.1.0`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/plutto-labs/plutto-ruby/graphs/contributors)!

Plutto Ruby SDK is maintained by [plutto](https://https://plutto.cl/).

## License

Plutto Ruby SDK is © 2021 plutto, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
