require './obscenity'

puts Obscenity.replacement('[censored]').sanitize('Wow! The robber ran the test multiple times so he could have red tests. Now he runs them less often. Dang straight theyre running')
#puts Obscenity.replacement('[censored]').sanitize('hello test. how the hell are running?')
#puts Obscenity.sanitize('Wow! it seems like Im running till my test')

