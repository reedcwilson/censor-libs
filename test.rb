require './obscenity'

times = 10000
num = 10
times.times do
  puts rand(0..num-1)
end
#puts Obscenity.sanitize('holy running. this is a test')
#puts Obscenity.replacement('[censored]').sanitize('hello test. how the hell are running?')
#puts Obscenity.sanitize('Wow! it seems like Im running till my test')

