Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name     = 'hash_to_object'
  s.version  = '0.1.0'
  s.date     = '2011-09-26'
  s.summary  = "Converts hashes into ruby objects."
  s.authors  = ["Phillip Birtcher"]
  s.email    = 'philbirt@gmail.com'
  s.homepage = 'https://github.com/philbirt/hash_to_object'
  s.require_paths = %w[lib]
  
  s.add_development_dependency('rspec', "~> 2.3")

  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    README.md
    Rakefile
    hash_to_object.gemspec
    lib/hash_to_object.rb
    spec/hash_to_object_spec.rb
  ]
  # = MANIFEST =

  s.test_files = s.files.select { |path| path =~ /^spec\/*._spec\.rb/ }
end
