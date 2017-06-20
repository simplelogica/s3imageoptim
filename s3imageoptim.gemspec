# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's3imageoptim/version'

Gem::Specification.new do |spec|
  spec.name          = "s3imageoptim"
  spec.version       = S3imageoptim::VERSION
  spec.authors       = ["Rodrigo Álvarez"]
  spec.email         = ["papipo@gmail.com"]

  spec.summary       = %q{Optimize images in a S3 bucket in a single command.}
  spec.description   = %q{s3imageoptim leverages s3cmd to compress all images in a full bucket or specific path of S3 recursively.}
  spec.homepage      = "https://github.com/simplelogica/s3imageoptim"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
