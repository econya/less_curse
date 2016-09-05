# LessCurse

Simple terminal-based ncurses UIs.

LessCurse is a work-in-progress, but it's unclear how much work and how much progress will happen/is needed.

It will probably just be developed enough to serve as a dead-simple TUI for the trackt time-tracking system.

Im happy about bug reports and ideas, but chances are high that I cannot react in the way I wish others would do.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lesscurse'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lesscurse

## Usage

See the examples folder for now.

## Concepts

### Screen

There is only one screen and it will fill up your terminal.  Access this screen via `LessCurse::screen` (or `LessCurse.screen`).

The screen can and should be populated by widgets.  No complex layouts are possible (yet).

### Widgets

All (two) widgets inherit from `LessCurse::Widgets::Base` and provide following methods:

  - `new(title: "Shows on top", data: "Shows somewhere")` [creates instance]
  - `refresh` [(re)draws the widget]
  - `handl_input(key)` [deals with input, if focused]

#### List

Shows a list where an item can be selected.

#### TextView

Shows text.

## Development

After checking out the repo, run `bundle` to install dependencies. You can also run `bundle console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Design goals and decisions

LessCurse aims to solve a specific problem and the library user (me) should be able to hack a UI with ease and without caring too much about configuration.

Thus, LessCurse is **very** oppinionated.

  - No complex layouts, only screen-tiling.
  - Few options.
  - No way to get lost in visual design decisions.

Widgets are for now not directly aware of the underlying (ncurses) window, this is a design decision workaround and yet on purpose.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/econya/less_curse.

