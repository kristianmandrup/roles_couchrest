require 'psych'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "roles_couchrest"
    gem.summary = %Q{Roles Generic API implementation for Simply Stored, a Couch DB mapper}
    gem.description = %Q{Roles Generic API implementation for the Couch DB mapper called Simply Stored}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/roles_couchrest"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.5.0"

    gem.add_dependency "sugar-high",                  "~> 0.4.0"
    gem.add_dependency "roles_generic",               "~> 0.3.0"
    gem.add_dependency "require_all",                 "~> 1.2.0"
    gem.add_dependency "couchrest",                   "~> 1.0.2"
    gem.add_dependency "couchrest_extended_document", "~> 1.0.0"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
