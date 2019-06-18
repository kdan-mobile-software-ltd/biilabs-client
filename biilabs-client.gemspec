Gem::Specification.new do |s|
  s.name        = 'biilabs-client'
  s.version     = '0.1.2'
  s.platform    = Gem::Platform::RUBY
  s.summary     = 'A gem to work with BiiLabs Tangle.'
  s.description = 'Wrapper for BiiLabs APIs'
  s.authors     = ['Ray Lee']
  s.email       = 'ray-lee@kdanmobile.com'
  s.homepage    = 'https://github.com/redtear1115/biilabs-client'
  s.license     = 'MIT'

  s.files            = [
    'lib/biilabs-client.rb',
    'lib/string.rb',
    'lib/trytes.rb'
  ]
  s.test_files       = ['spec/biilabs-client_spec.rb']
  s.extra_rdoc_files = [ 'README.md' ]
  s.rdoc_options     = ['--charset=UTF-8']

  s.required_ruby_version = '>= 2.3.1'
  s.add_runtime_dependency 'faraday', '~> 0.15'
  s.add_runtime_dependency 'json', '~> 2.2'
  s.add_development_dependency 'rspec', '~> 3.8.0'
end
