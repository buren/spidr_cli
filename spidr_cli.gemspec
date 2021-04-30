
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spidr_cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'spidr_cli'
  spec.version       = SpidrCLI::VERSION
  spec.authors       = ['Jacob Burenstam']
  spec.email         = ['burenstam@gmail.com']

  spec.summary       = 'CLI for the spidr gem'
  spec.description   = 'Command Line Interface (CLI) for the spidr gem.'
  spec.homepage      = 'https://github.com/buren/spidr_cli'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'spidr', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'simplecov'
end
