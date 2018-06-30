# SpidrCLI

Command Line Interface (CLI) for the excellent [`spidr`](https://github.com/postmodern/spidr) gem.

## Installation

Install with

    $ gem install spidr_cli

## Usage

Print all found pages

```
$ spidr http://solnic.eu/
```

Print all HTML/JS/CSS pages
```
$ spidr --content-types=html,javascript,css http://solnic.eu/
```

Max 10 pages
```
$ spidr --limit=10 http://solnic.eu/
```

Any method that [`Spidr::Page`](https://github.com/postmodern/spidr/blob/master/lib/spidr/page.rb) responds to you can output, you can also choose to include the header in the output (which is valid CSV)
```
$ spidr --columns=code,content_type,url --header http://solnic.eu/
```

Full usage instructions

```
Usage: spidr [options] <url>
        --columns=[val1,val2]        Columns in output
        --content-types=[val1,val2]  Formats to output (html, javascript, css, json, ..)
        --[no-]header                Include the header
        --open-timeout=val           Optional open timeout
        --read-timeout=val           Optional read timeout
        --ssl-timeout=val            Optional ssl timeout
        --continue-timeout=val       Optional continue timeout
        --keep-alive-timeout=val     Optional keep_alive timeout
        --proxy-host=val             The host the proxy is running on
        --proxy-port=val             The port the proxy is running on
        --proxy-user=val             The user to authenticate as with the proxy
        --proxy-password=val         The password to authenticate with
        --default-headers=[key1=val1,key2=val2]
                                     Default headers to set for every request
        --host-header=val            The HTTP Host header to use with each request
        --host-headers=[key1=val1,key2=val2]
                                     The HTTP Host headers to use for specific hosts
        --user-agent=val             The User-Agent string to send with each requests
        --referer=val                The Referer URL to send with each request
        --delay=val                  The number of seconds to pause between each request
        --queue=[val1,val2]          The initial queue of URLs to visit
        --history=[val1,val2]        The initial list of visited URLs
        --limit=val                  The maximum number of pages to visit
        --max-depth=val              The maximum link depth to follow
        --[no-]robots                Respect Robots.txt
    -h, --help                       How to use
        --version                    Show version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/buren/spidr_cli.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
