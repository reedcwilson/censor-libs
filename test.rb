require './obscenity'

puts Obscenity::Base.replacement('[censored]').sanitize('holy running. this is a test')
puts Obscenity::Base.replacement('[censored]').sanitize('hello test. how the hell are running?')
