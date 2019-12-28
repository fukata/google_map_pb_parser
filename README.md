# GoogleMapPbParser

This is parser of Google Map embed parameter `pb`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google_map_pb_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install google_map_pb_parser

## Structure of pb

https://www.google.co.jp/maps/place/Standing+Buddha/@21.2875125,99.5945486,17z/data=!3m1!4b1!4m5!3m4!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!8m2!3d21.2875075!4d99.5967373
```
pb = '!1m18!1m12!1m3!1d3717.560901381966!2d99.5956620927018!3d21.288842013619135!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!2sStanding%20Buddha!5e0!3m2!1sja!2sth!4v1576440979089!5m2!1sja!2sth'
```

```
!1m18
    !1m12
        !1m3
            !1d3717.560901381966
            !2d99.5956620927018
            !3d21.288842013619135
        !2m3
            !1f0
            !2f0
            !3f0
        !3m2
            !1i1024
            !2i768
        !4f13.1
        !3m3
            !1m2
                !1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d
                !2sStanding%20Buddha
        !5e0
!3m2
    !1sja
    !2sth
!4v1576440979089
!5m2
    !1sja
    !2sth'
```

## Usage

```ruby
pb = '!1m18!1m12!1m3!1d3717.560901381966!2d99.5956620927018!3d21.288842013619135!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d!2sStanding%20Buddha!5e0!3m2!1sja!2sth!4v1576440979089!5m2!1sja!2sth'
result = GoogleMapPbParser.parse(pb)
p result

pb = GoogleMapPbParser.decode_result(result)
p pb
```

Example

```ruby
# result
[
  {
    :id=>'1',
    :raw=>"1m18",
    :type=>"m",
    :value=> [
      {
        :id=>'1',
        :raw=>"1m12",
        :type=>"m",
        :value=> [
          {
            :id=>'1',
            :raw=>"1m3",
            :type=>"m",
            :value=> [
              {:id=>'1', :raw=>"1d3717.560901381966", :type=>"d", :value=>"3717.560901381966"},
              {:id=>'2', :raw=>"2d99.5956620927018", :type=>"d", :value=>"99.5956620927018"},
              {:id=>'3', :raw=>"3d21.288842013619135", :type=>"d", :value=>"21.288842013619135"}
            ]
          },
          {
            :id=>'2',
            :raw=>"2m3",
            :type=>"m",
            :value=> [
              {:id=>'1', :raw=>"1f0", :type=>"f", :value=>"0"},
              {:id=>'2', :raw=>"2f0", :type=>"f", :value=>"0"},
              {:id=>'3', :raw=>"3f0", :type=>"f", :value=>"0"}
            ]
          },
          {
            :id=>'3',
            :raw=>"3m2",
            :type=>"m",
            :value=> [
              {:id=>'1', :raw=>"1i1024", :type=>"i", :value=>"1024"},
              {:id=>'2', :raw=>"2i768", :type=>"i", :value=>"768"}
            ]
          },
          {:id=>'4', :raw=>"4f13.1", :type=>"f", :value=>"13.1"}
        ]
      },
      {
        :id=>'3',
        :raw=>"3m3",
        :type=>"m",
        :value=> [
          {
            :id=>'1',
            :raw=>"1m2",
            :type=>"m",
            :value=> [
              {:id=>'1', :raw=>"1s0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d", :type=>"s", :value=>"0x30d4417bb9d2cb77:0x3aa5ca84cbdd9e7d"},
              {:id=>'2', :raw=>"2sStanding%20Buddha", :type=>"s", :value=>"Standing%20Buddha"}
            ]
          }
        ]
      },
      {:id=>'5', :raw=>"5e0", :type=>"e", :value=>"0"}
    ]
  },
  {
    :id=>'3',
    :raw=>"3m2",
    :type=>"m",
    :value=> [
      {:id=>'1', :raw=>"1sja", :type=>"s", :value=>"ja"},
      {:id=>'2', :raw=>"2sth", :type=>"s", :value=>"th"}
    ]
  },
  {:id=>'4', :raw=>"4v1576440979089", :type=>"v", :value=>"1576440979089"},
  {
    :id=>'5',
    :raw=>"5m2",
    :type=>"m",
    :value=> [
      {:id=>'1', :raw=>"1sja", :type=>"s", :value=>"ja"},
      {:id=>'2', :raw=>"2sth", :type=>"s", :value=>"th"}
    ]
  }
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fukata/google_map_pb_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GoogleMapPbParser project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fukata/google_map_pb_parser/blob/master/CODE_OF_CONDUCT.md).
