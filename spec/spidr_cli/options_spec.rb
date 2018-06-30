require 'spec_helper'


RSpec.describe SpidrCLI::Options do
  describe '#columns' do
    it 'returns default if no argument given' do
      options = described_class.new([])
      expect(options.columns).to eq(%w[url])
    end

    it 'returns argument as array' do
      options = described_class.new(['--columns=url,code'])
      expect(options.columns).to eq(%w[url code])
    end
  end

  describe '#content_types' do
    it 'returns default if no argument given' do
      options = described_class.new([])
      expect(options.content_types).to be_nil
    end

    it 'returns argument as array' do
      options = described_class.new(['--content-types=html,png'])
      expect(options.content_types).to eq(%w[html png])
    end
  end

  describe '#header' do
    it 'returns default if no argument given' do
      options = described_class.new([])
      expect(options.header).to eq(false)
    end

    it 'returns true if given --header' do
      options = described_class.new(['--header'])
      expect(options.header).to eq(true)
    end

    it 'returns true if given --no-header' do
      options = described_class.new(['--no-header'])
      expect(options.header).to eq(false)
    end
  end

  context 'Spidr options' do
    describe 'ports' do
      it 'has no ports key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:ports)).to eq(false)
      end

      it 'returns ports argument as Array<Integer>' do
        options = described_class.new(['--ports=1,3000'])
        expect(options.spidr_options[:ports]).to eq([1, 3000])
      end
    end

    describe 'ignore_ports' do
      it 'has no ignore_ports key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:ignore_ports)).to eq(false)
      end

      it 'returns ignore_ports argument as Array<Integer>' do
        options = described_class.new(['--ignore-ports=1,3000'])
        expect(options.spidr_options[:ignore_ports]).to eq([1, 3000])
      end
    end

    %i[links urls exts].each do |arg|
      describe "#{arg}", focus: true do
        it "has no #{arg} key if no argument given" do
          options = described_class.new([])
          expect(options.spidr_options.key?(arg)).to eq(false)
        end

        it "returns #{arg} argument as Array<Regexp>" do
          options = described_class.new(["--#{arg}=/blog/"])
          expect(options.spidr_options[arg]).to eq([/\/blog\//])
        end
      end

      describe "ignore_#{arg}" do
        it "has no ignore_#{arg} key if no argument given" do
          options = described_class.new([])
          expect(options.spidr_options.key?(:"ignore_#{arg}")).to eq(false)
        end

        it "returns ignore_#{arg} argument as Array<Regexp>" do
          options = described_class.new(["--ignore-#{arg}=/blog/"])
          expect(options.spidr_options[:"ignore_#{arg}"]).to eq([/\/blog\//])
        end
      end
    end

    describe 'open_timeout' do
      it 'has no open_timeout key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:open_timeout)).to eq(false)
      end

      it 'returns open_timeout argument as Integer' do
        options = described_class.new(['--open-timeout=1'])
        expect(options.spidr_options[:open_timeout]).to eq(1)
      end
    end

    describe 'read_timeout' do
      it 'has no read_timeout key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:read_timeout)).to eq(false)
      end

      it 'returns read_timeout argument as Integer' do
        options = described_class.new(['--read-timeout=1'])
        expect(options.spidr_options[:read_timeout]).to eq(1)
      end
    end

    describe 'ssl_timeout' do
      it 'has no ssl_timeout key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:ssl_timeout)).to eq(false)
      end

      it 'returns ssl_timeout argument as Integer' do
        options = described_class.new(['--ssl-timeout=1'])
        expect(options.spidr_options[:ssl_timeout]).to eq(1)
      end
    end

    describe 'continue_timeout' do
      it 'has no continue_timeout key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:continue_timeout)).to eq(false)
      end

      it 'returns continue_timeout argument as Integer' do
        options = described_class.new(['--continue-timeout=1'])
        expect(options.spidr_options[:continue_timeout]).to eq(1)
      end
    end

    describe 'keep_alive_timeout' do
      it 'has no keep_alive_timeout key if no argument given' do
        options = described_class.new([])
        expect(options.spidr_options.key?(:keep_alive_timeout)).to eq(false)
      end

      it 'returns keep_alive_timeout argument as Integer' do
        options = described_class.new(['--keep-alive-timeout=1'])
        expect(options.spidr_options[:keep_alive_timeout]).to eq(1)
      end
    end

    describe "proxy option" do
      describe 'hash no proxy arguments are present' do
        it 'options has no proxy-key' do
          options = described_class.new([])
          expect(options.spidr_options.key?(:proxy)).to eq(false)
        end
      end

      describe 'host' do
        it 'has no host key if no argument given' do
          options = described_class.new(['--proxy-port=3000'])
          expect(options.spidr_options[:proxy].key?(:host)).to eq(false)
        end

        it 'returns host argument as String' do
          options = described_class.new(['--proxy-host=test'])
          expect(options.spidr_options.dig(:proxy, :host)).to eq('test')
        end
      end

      describe 'port' do
        it 'has no port key if no argument given' do
          options = described_class.new(['--proxy-host=asd'])
          expect(options.spidr_options[:proxy].key?(:port)).to eq(false)
        end

        it 'returns port argument as Integer' do
          options = described_class.new(['--proxy-port=3000'])
          expect(options.spidr_options.dig(:proxy, :port)).to eq(3000)
        end
      end

      describe 'user' do
        it 'has no user key if no argument given' do
          options = described_class.new(['--proxy-port=3000'])
          expect(options.spidr_options[:proxy].key?(:user)).to eq(false)
        end

        it 'returns user argument as String' do
          options = described_class.new(['--proxy-user=test'])
          expect(options.spidr_options.dig(:proxy, :user)).to eq('test')
        end
      end

      describe 'password' do
        it 'has no password key if no argument given' do
          options = described_class.new(['--proxy-port=3000'])
          expect(options.spidr_options[:proxy].key?(:password)).to eq(false)
        end

        it 'returns password argument as String' do
          options = described_class.new(['--proxy-password=test'])
          expect(options.spidr_options.dig(:proxy, :password)).to eq('test')
        end
      end
    end
  end

  describe 'default_headers' do
    it 'has no default_headers key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:default_headers)).to eq(false)
    end

    it 'returns host argument as Hash' do
      options = described_class.new(['--default-headers=key1=val1,key2=val2'])
      expected = { 'key1' => 'val1', 'key2' => 'val2' }
      expect(options.spidr_options[:default_headers]).to eq(expected)
    end
  end

  describe 'host_header' do
    it 'has no host_header key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:host_header)).to eq(false)
    end

    it 'returns host_header argument as String' do
      options = described_class.new(['--host-header=test'])
      expect(options.spidr_options[:host_header]).to eq('test')
    end
  end

  describe 'host_headers' do
    it 'has no host_headers key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:host_headers)).to eq(false)
    end

    it 'returns host argument as Hash' do
      options = described_class.new(['--host-headers=key1=val1,key2=val2'])
      expected = { 'key1' => 'val1', 'key2' => 'val2' }
      expect(options.spidr_options[:host_headers]).to eq(expected)
    end
  end

  describe 'user_agent' do
    it 'has no user_agent key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:user_agent)).to eq(false)
    end

    it 'returns user_agent argument as String' do
      options = described_class.new(['--user-agent=test'])
      expect(options.spidr_options[:user_agent]).to eq('test')
    end
  end

  describe 'referer' do
    it 'has no referer key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:referer)).to eq(false)
    end

    it 'returns referer argument as String' do
      options = described_class.new(['--referer=test'])
      expect(options.spidr_options[:referer]).to eq('test')
    end
  end

  describe 'delay' do
    it 'has no delay key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:delay)).to eq(false)
    end

    it 'returns delay argument as Integer' do
      options = described_class.new(['--delay=1'])
      expect(options.spidr_options[:delay]).to eq(1)
    end
  end

  describe '#queue' do
    it 'returns default if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options[:queue]).to be_nil
    end

    it 'returns argument as array' do
      options = described_class.new(['--queue=example.com,second.example.com'])
      expect(options.spidr_options[:queue]).to eq(%w[example.com second.example.com])
    end
  end

  describe '#history' do
    it 'returns default if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options[:history]).to be_nil
    end

    it 'returns argument as array' do
      options = described_class.new(['--history=example.com,second.example.com'])
      expect(options.spidr_options[:history]).to eq(%w[example.com second.example.com])
    end
  end

  describe 'limit' do
    it 'has no limit key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:limit)).to eq(false)
    end

    it 'returns limit argument as Integer' do
      options = described_class.new(['--limit=1'])
      expect(options.spidr_options[:limit]).to eq(1)
    end
  end

  describe 'max_depth' do
    it 'has no max_depth key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:max_depth)).to eq(false)
    end

    it 'returns max_depth argument as Integer' do
      options = described_class.new(['--max-depth=1'])
      expect(options.spidr_options[:max_depth]).to eq(1)
    end
  end

  describe 'robots' do
    it 'has no robots key if no argument given' do
      options = described_class.new([])
      expect(options.spidr_options.key?(:robots)).to eq(false)
    end

    it 'returns true if given --robots' do
      options = described_class.new(['--robots'])
      expect(options.spidr_options[:robots]).to eq(true)
    end

    it 'returns true if given --no-robots' do
      options = described_class.new(['--no-robots'])
      expect(options.spidr_options[:robots]).to eq(false)
    end
  end
end
