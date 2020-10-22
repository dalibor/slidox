# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slidox/version'

Gem::Specification.new do |spec|
  spec.name          = "slidox"
  spec.version       = Slidox::VERSION
  spec.authors       = ["Dalibor Nasevic"]
  spec.email         = ["dalibor.nasevic@gmail.com"]
  spec.summary       = %q{Markdown to PDF and HTML}
  spec.description   = %q{Markdown to PDF and HTML conversion tool. Useful for building presentations and other documents.}
  spec.homepage      = "https://github.com/dalibor/slidox"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "github-markdown", "~> 0.6"
  spec.add_dependency "pdfkit", "~> 0.8.2"
  spec.add_dependency "pygments.rb", "~> 0.6"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "wkhtmltopdf-binary", "0.12.3.1"
end
