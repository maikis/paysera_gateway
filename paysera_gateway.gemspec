$:.push File.expand_path('../lib', __FILE__)

require 'paysera_gateway/version'

Gem::Specification.new do |s|
  s.name        = 'paysera_gateway'
  s.version     = PayseraGateway::VERSION
  s.authors     = ['Mykolas Grinevičius']
  s.email       = ['mykolas@grineviciai.eu']
  s.homepage    = 'https://github.com/maikis/paysera_gateway.git'
  s.summary     = 'Paysera online payment integration API.'
  s.description = 'This API helps integrating Paysera payments to ruby '\
                  'projects. It takes care of converting params to the '\
                  'proper form and makes all the communication between '\
                  'your ruby application and Paysera easy.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '~> 5.1.6'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.7'
  s.add_development_dependency 'byebug', '~> 10.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rubocop', '~> 0.53'
  s.add_development_dependency 'webmock', '~> 3.4'
end
