# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmxcheckout/version'

Gem::Specification.new do |spec|
  spec.name          = 'gmxcheckout'
  spec.version       = GmxCheckout::VERSION
  spec.authors       = ['Rainer Borene']
  spec.email         = ['rainerborene@gmail.com']

  spec.summary       = 'Charge your customers in a monthly basis using gmxCheckout'
  spec.description   = 'A simple and easy to use library to integrate with gmxCheckout'
  spec.homepage      = 'https://github.com/rainerborene/gmxcheckoR'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'hashie'
  spec.add_dependency 'multi_json'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'vcr'
end
