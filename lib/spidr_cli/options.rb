require 'optparse'

module SpidrCLI
  class Options
    # Spidr methods
    METHODS = %w[site start_at host].map { |c| [c, c] }.to_h.freeze

    attr_reader :url, :columns, :content_types, :header, :spidr_options, :usage_doc,
                :spidr_method

    def initialize(argv = ARGV)
      @url = nil
      @columns = %w[url]
      @content_types = nil
      @header = false
      @usage_doc = nil
      @spidr_method = 'site'
      @spidr_options = {}

      parse_options(argv)
    end

    private

    def parse_options(argv)
      proxy_options = {}
      @spidr_method = METHODS[argv.first] if METHODS.key?(argv.first)

      OptionParser.new do |parser|
        @usage_doc = parser.to_s

        parser.banner = 'Usage: spidr [<method>] [options] <url>'
        parser.default_argv = argv

        parser.on('--columns=[val1,val2]', Array, 'Columns in output') do |value|
          @columns = value || columns
        end

        parser.on('--content-types=[val1,val2]', Array, 'Formats to output (html, javascript, css, json, ..)') do |value|
          @content_types = value
        end

        parser.on('--[no-]header', 'Include the header') do |value|
          @header = value
        end

        # Spidr::Sanitizers options
        parser.on('--[no-]strip-fragments', 'Specifies whether the Agent will strip URI fragments (default: true)') do |value|
          spidr_options[:strip_fragments] = value
        end

        parser.on('--[no-]strip-query', 'Specifies whether the Agent will strip URI query (default: false)') do |value|
          spidr_options[:strip_query] = value
        end

        # Spidr::Filters options
        parser.on('--schemes=[http,https]', Array, 'Only spider links with certain scheme') do |value|
          spidr_options[:schemes] = value if value
        end

        parser.on('--host=[example]', String, 'Only spider links on certain host') do |value|
          spidr_options[:host] = value if value
        end

        # NOTE: --hosts is overriden
        #   @see https://github.com/postmodern/spidr/blob/master/lib/spidr/agent.rb#L273
        parser.on('--hosts=[example.com]', Array, 'Only spider links on certain hosts (ignored unless method is "start_at" or "site")') do |value|
          spidr_options[:hosts] = to_option_regexp_array(value) if value
        end

        # NOTE: --ignore-hosts is overriden
        #   @see https://github.com/postmodern/spidr/blob/master/lib/spidr/agent.rb#L273
        parser.on('--ignore-hosts=[www.example.com]', Array, 'Do not spider links on certain hosts (ignored unless method is "start_at" or "site")') do |value|
          spidr_options[:ignore_hosts] = to_option_regexp_array(value) if value
        end

        parser.on('--ports=[80, 443]', Array, 'Only spider links on certain ports') do |value|
          spidr_options[:ports] = to_option_int_array(value) if value
        end

        parser.on('--ignore-ports=[8000, 8080, 3000]', Array, 'Do not spider links on certain ports') do |value|
          spidr_options[:ignore_ports] = to_option_int_array(value) if value
        end

        parser.on('--links=[/blog/]', Array, 'Only spider links on certain link patterns') do |value|
          spidr_options[:links] = to_option_regexp_array(value) if value
        end

        parser.on('--ignore-links=[/blog/]', Array, 'Do not spider links on certain link patterns') do |value|
          spidr_options[:ignore_links] = to_option_regexp_array(value) if value
        end

        parser.on('--urls=[/blog/]', Array, 'Only spider links on certain urls') do |value|
          spidr_options[:urls] = to_option_regexp_array(value) if value
        end

        parser.on('--ignore-urls=[/blog/]', Array, 'Do not spider links on certain urls') do |value|
          spidr_options[:ignore_urls] = to_option_regexp_array(value) if value
        end

        parser.on('--exts=[htm]', Array, 'Only spider links on certain extensions') do |value|
          spidr_options[:exts] = to_option_regexp_array(value) if value
        end

        parser.on('--ignore-exts=[cfm]', Array, 'Do not spider links on certain extensions') do |value|
          spidr_options[:ignore_exts] = to_option_regexp_array(value) if value
        end

        # Spidr::Agent options
        parser.on('--open-timeout=val', Integer, 'Open timeout') do |value|
          spidr_options[:open_timeout] = value
        end

        parser.on('--read-timeout=val', Integer, 'Read timeout') do |value|
          spidr_options[:read_timeout] = value
        end

        parser.on('--ssl-timeout=val', Integer, 'SSL timeout') do |value|
          spidr_options[:ssl_timeout] = value
        end

        parser.on('--continue-timeout=val', Integer, 'Continue timeout') do |value|
          spidr_options[:continue_timeout] = value
        end

        parser.on('--keep-alive-timeout=val', Integer, 'Keep alive timeout') do |value|
          spidr_options[:keep_alive_timeout] = value
        end

        parser.on('--proxy-host=val', String, 'The host the proxy is running on') do |value|
          proxy_options[:host] = value
        end

        parser.on('--proxy-port=val', Integer, 'The port the proxy is running on') do |value|
          proxy_options[:port] = value
        end

        parser.on('--proxy-user=val', String, 'The user to authenticate with the proxy') do |value|
          proxy_options[:user] = value
        end

        parser.on('--proxy-password=val', String, 'The password to authenticate with the proxy') do |value|
          proxy_options[:password] = value
        end

        parser.on('--default-headers=[key1=val1,key2=val2]', Array, 'Default headers to set for every request') do |value|
          spidr_options[:default_headers] = option_hash(value || [])
        end

        parser.on('--host-header=val', String, 'The HTTP Host header to use with each request') do |value|
          spidr_options[:host_header] = value
        end

        parser.on('--host-headers=[key1=val1,key2=val2]', Array, 'The HTTP Host headers to use for specific hosts') do |value|
          spidr_options[:host_headers] = option_hash(value || [])
        end

        parser.on('--user-agent=val', String, 'The User-Agent string to send with each requests') do |value|
          spidr_options[:user_agent] = value
        end

        parser.on('--referer=val', String, 'The Referer URL to send with each request') do |value|
          spidr_options[:referer] = value
        end

        parser.on('--delay=val', Integer, 'The number of seconds to pause between each request') do |value|
          spidr_options[:delay] = value
        end

        parser.on('--queue=[val1,val2]', Array, 'The initial queue of URLs to visit') do |value|
          spidr_options[:queue] = value
        end

        parser.on('--history=[val1,val2]', Array, 'The initial list of visited URLs') do |value|
          spidr_options[:history] = value
        end

        parser.on('--limit=val', Integer, 'The maximum number of pages to visit') do |value|
          spidr_options[:limit] = value
        end

        parser.on('--max-depth=val', Integer, 'The maximum link depth to follow') do |value|
          spidr_options[:max_depth] = value
        end

        parser.on('--[no-]robots', 'Respect Robots.txt') do |value|
          spidr_options[:robots] = value
        end

        # Boilerplate CLI
        parser.on('-h', '--help', 'How to use') do
          puts parser
          exit
        end

        parser.on_tail('--version', 'Show version') do
          puts "Spidr version #{Spidr::VERSION} (SpidrCLI version #{SpidrCLI::VERSION})"
          exit
        end
      end.parse!

      if @spidr_method != 'start_at' &&
          (spidr_options.key?(:hosts) || spidr_options.key?(:ignore_hosts))
        raise(ArgumentError, '--hosts and --ignore-hosts argument are only valid if spidr method is "start_at" or "site"')
      end

      spidr_options[:proxy] = proxy_options unless proxy_options.empty?

      @url = argv.last
    end

    def to_option_int_array(value)
      value.map { |v| Integer(v) }
    end

    def to_option_regexp_array(value)
      value.map { |v| Regexp.new(v) }
    end

    def option_hash(value)
      value.map { |v| v.split('=') }.to_h
    end
  end
end
