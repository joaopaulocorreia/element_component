# ElementComponent

HTML builder

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add element_component
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install element_component
```

## Usage

```ruby
maker = ElementComponent::Core::Maker.new
form = maker.form(attribute: { class: 'has-background-color', method: 'GET', action: '/', turbo: false }) do |form|
  input = maker.input(attribute: { type: 'text', name: 'email', value: nil })
  form.add_content input

  button = maker.button(content: 'Save', attribute: { type: 'submit'})
  div    = maker.div(content: button, attribute: { class: 'buttons' })

  form.add_content div
end

puts form.build
```

## Output

```html
<form class="has-background-color" method="GET" action="/" turbo="false"><input type="text" name="email" value=""></input><div class="buttons"><button type="submit">Save</button></div></form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO
[ ] - Cache
[ ] - Bulma components
[ ] - Bootstrap components

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joaopaulocorreia/element_component.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
