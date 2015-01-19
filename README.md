# censor-libs
Censors string containing profanity in a Mad Libs fashion

usage:

(assuming 'naughty' and 'robber' are blacklisted words)

if 'naughty' is an adjective and 'robber' is a noun

``` ruby
Obscenity.sanitize('this is a naughty string about a nasty robber')

> this is a [cantankerous] string about a nasty [didgeridoo]
```

if 'naughty' and 'bad' are identified as 'other'

``` ruby
Obscenity.replacement('[censored]').sanitize('this is a naughty string about a nasty robber')

> this is a [censored] string about a nasty [censored]
```
