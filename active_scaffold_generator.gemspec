# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_scaffold_generator}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tyler Rick"]
  s.date = %q{2010-08-13}
  s.description = %q{This generator creates a controller with the given name and adds an active_scaffold declaration inside of it, listing all column names and association names, so that you can quickly start customizing it (reordering or removing columns, for example).}
  s.email = %q{github.com@tylerrick.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "active_scaffold_generator.gemspec",
     "generators/active_scaffold/USAGE",
     "generators/active_scaffold/active_scaffold_generator.rb",
     "generators/active_scaffold/templates/active_scaffold_controller.rb",
     "lib/active_scaffold_generator.rb",
     "test/helper.rb",
     "test/test_active_scaffold_generator.rb"
  ]
  s.homepage = %q{http://github.com/TylerRick/active_scaffold_generator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Generate new active_scaffold controllers with ease}
  s.test_files = [
    "test/test_active_scaffold_generator.rb",
     "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end

