$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'seo_cms/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'seo_cms'
  s.version     = SeoCms::VERSION
  s.authors     = ['Romain Vigo Benia']
  s.email       = ['romain@livementor.com']
  s.homepage    = 'http://www.livementor.com'
  s.summary     = 'simple SEO static CMS.'
  s.description = 'simple SEO static CMS.'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_runtime_dependency 'rails', '~> 3.2'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'test-unit'
end
