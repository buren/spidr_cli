# SpidrCLI [![Build Status](https://travis-ci.org/buren/spidr_cli.svg?branch=master)](https://travis-ci.org/buren/spidr_cli)

Command Line Interface (CLI) for the excellent [`spidr`](https://github.com/postmodern/spidr) gem.

## Installation

Install with

    $ gem install spidr_cli

## Usage

Print all found pages on site

```
$ spidr https://jacoburenstam.com/
```

Print all HTML/JS/CSS pages
```
$ spidr --content-types=html,javascript,css https://jacoburenstam.com/
```

Max 10 pages
```
$ spidr --limit=10 https://jacoburenstam.com/
```

Spidr host
```
$ spidr host jacoburenstam.com
```

Spidr a single site (this is the default)
```
$ spidr site https://jacoburenstam.com
```

Start spidr from URL
```
$ spidr start_at https://jacoburenstam.com
```

Any method that [`Spidr::Page`](https://github.com/postmodern/spidr/blob/master/lib/spidr/page.rb) responds to you can output, you can also choose to include the header in the output (which is valid CSV)
```
$ spidr --columns=code,content_type,url \
        --header                        \
        https://jacoburenstam.com/
```

Full usage instructions

```
Usage: spidr [<method>] [options] <url>
        --columns=[val1,val2]        Columns in output
        --content-types=[val1,val2]  Formats to output (html, javascript, css, json, ..)
        --[no-]header                Include the header
        --[no-]strip-fragments       Specifies whether the Agent will strip URI fragments (default: true)
        --[no-]strip-query           Specifies whether the Agent will strip URI query (default: false)
        --schemes=[http,https]       Only spider links with certain scheme
        --host=[example]             Only spider links on certain host
        --hosts=[example.com]        Only spider links on certain hosts (ignored unless method is "start_at" or "site")
        --ignore-hosts=[www.example.com]
                                     Do not spider links on certain hosts (ignored unless method is "start_at" or "site")
        --ports=[80, 443]            Only spider links on certain ports
        --ignore-ports=[8000, 8080, 3000]
                                     Do not spider links on certain ports
        --links=[/blog/]             Only spider links on certain link patterns
        --ignore-links=[/blog/]      Do not spider links on certain link patterns
        --urls=[/blog/]              Only spider links on certain urls
        --ignore-urls=[/blog/]       Do not spider links on certain urls
        --exts=[htm]                 Only spider links on certain extensions
        --ignore-exts=[cfm]          Do not spider links on certain extensions
        --open-timeout=val           Open timeout
        --read-timeout=val           Read timeout
        --ssl-timeout=val            SSL timeout
        --continue-timeout=val       Continue timeout
        --keep-alive-timeout=val     Keep alive timeout
        --proxy-host=val             The host the proxy is running on
        --proxy-port=val             The port the proxy is running on
        --proxy-user=val             The user to authenticate with the proxy
        --proxy-password=val         The password to authenticate with the proxy
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

## Thanks

Huge thanks to [@postmodern](https://github.com/postmodern) for creating [`spidr`](https://github.com/postmodern/spidr) :star:
