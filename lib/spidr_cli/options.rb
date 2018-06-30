require 'optparse'

module SpidrCLI
  class Options
    attr_reader :url, :columns, :content_types, :header, :spidr_options, :usage_doc

    def initialize(argv = ARGV)
      @url = nil
      @columns = %w[url]
      @content_types = nil
      @header = false
      @usage_doc = nil
      @spidr_options = {}

      parse_options(argv)
    end

    private

    def parse_options(argv)
      proxy_options = {}

      OptionParser.new do |parser|
        @usage_doc = parser.to_s

        parser.banner = 'Usage: spidr [options] <url>'
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

        # Spidr::Agent options
        parser.on('--open-timeout=val', Integer, 'Optional open timeout') do |value|
          spidr_options[:open_timeout] = value
        end

        parser.on('--read-timeout=val', Integer, 'Optional read timeout') do |value|
          spidr_options[:read_timeout] = value
        end

        parser.on('--ssl-timeout=val', Integer, 'Optional ssl timeout') do |value|
          spidr_options[:ssl_timeout] = value
        end

        parser.on('--continue-timeout=val', Integer, 'Optional continue timeout') do |value|
          spidr_options[:continue_timeout] = value
        end

        parser.on('--keep-alive-timeout=val', Integer, 'Optional keep_alive timeout') do |value|
          spidr_options[:keep_alive_timeout] = value
        end

        parser.on('--proxy-host=val', String, 'The host the proxy is running on') do |value|
          proxy_options[:host] = value
        end

        parser.on('--proxy-port=val', Integer, 'The port the proxy is running on') do |value|
          proxy_options[:port] = value
        end

        parser.on('--proxy-user=val', String, 'The user to authenticate as with the proxy') do |value|
          proxy_options[:user] = value
        end

        parser.on('--proxy-password=val', String, 'The password to authenticate with') do |value|
          proxy_options[:password] = value
        end

        parser.on('--default-headers=[key1=val1,key2=val2]', Array, 'Default headers to set for every request') do |value|
          spidr_options[:default_headers] = (value || []).map { |v| v.split('=') }.to_h
        end

        parser.on('--host-header=val', String, 'The HTTP Host header to use with each request') do |value|
          spidr_options[:host_header] = value
        end

        parser.on('--host-headers=[key1=val1,key2=val2]', Array, 'The HTTP Host headers to use for specific hosts') do |value|
          spidr_options[:host_headers] = (value || []).map { |v| v.split('=') }.to_h
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
          puts "Spidr version #{Spidr::VERSION}"
          exit
        end
      end.parse!

      spidr_options[:proxy] = proxy_options unless proxy_options.empty?

      @url = ARGV.last
    end
  end
end