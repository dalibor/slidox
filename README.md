# Slidox

Markdown to PDF and HTML conversion tool, useful for building presentations and other documents.

## Dependencies

```
sudo apt-get install libicu-dev
sudo apt-get install cmake
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slidox'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install slidox
```

## Usage

Generate new presentation

```bash
slidox new presentation
```

To build HTML and PDF for the presentation:

```bash
cd presentation
slidox build
```

You can tweak `config.yml` for export options and change presentation styles with assets.


## Contributing

1. Fork it ( https://github.com/dalibor/slidox/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
