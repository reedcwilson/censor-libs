require './obscenity'

puts Obscenity.sanitize('holy running. this is a test')
puts Obscenity.replacement('[censored]').sanitize('hello test. how the hell are running?')
