# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seats/version'

Gem::Specification.new do |spec|
  spec.name          = 'seats'
  spec.version       = Seats::VERSION
  spec.authors       = ['Nathan Currier']
  spec.email         = ['nathan.currier@gmail.com']
  spec.license       = 'BSL-1.0'

  spec.summary       = %q{Discover who is seated at a machine.}
  spec.description   = %q{Discover users who are connected locally or remotely to a machine.}
  spec.homepage      = 'https://gem.rideliner.net'

  # Prevent pushing this gem to RubyGems.org
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://gem.rideliner.net'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
end
