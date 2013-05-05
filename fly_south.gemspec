Gem::Specification.new do |s|
  s.name        = 'fly_south'
  s.version     = '0.0.0'
  s.date        = '2013-05-05'
  s.summary     = 'A simple, modular migration framework.'
  s.description = s.summary

  s.author      = 'Daniel Tomasiewicz'
  s.email       = 'me@dtomasiewicz.com'
  s.homepage    = 'http://github.com/dtomasiewicz/fly_south'

  s.files       = Dir['{bin,lib}/**/*', 'README*', 'LICENSE']
  s.executables << 'migrate'
end