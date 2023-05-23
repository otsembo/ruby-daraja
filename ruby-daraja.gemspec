# frozen_string_literal: true

require_relative 'lib/ruby/daraja/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby-daraja'
  spec.version = Ruby::Daraja::VERSION
  spec.authors = ['otsembo']
  spec.email = ['okumu.otsembo@gmail.com']

  spec.summary = 'A simple gem that allows implements smooth'
  spec.description = "The gem abstracts away the low-level details of the API, providing a simple and intuitive
interface for sending payment requests, checking payment status, and managing payment callbacks"
  spec.homepage = 'https://github.com/otsembo/ruby-daraja'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # spec.metadata['allowed_push_host'] = 'https://github.com'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = 'https://github.com/otsembo/ruby-daraja'
  spec.metadata['source_code_uri'] = 'https://github.com/otsembo/ruby-daraja'
  spec.metadata['changelog_uri'] = 'https://github.com/otsembo/ruby-daraja/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
