[x] cascading flags (still need tests)

[x] default root command/namespace that can be overidden

[x] think about starting a command instead of setting root and starting
hal9k. this would easily allow cli's to be reused. not sure why you
might need this but maybe useful during refactoring, say you wanted
to extract a command. you could easily use just that command by just
yea, then could do Heroku::Cli.start
and if you had multiple cli's in a project, you would need this anywho
starting hal9k with it.

[x] Move type of flag to separate class that the instance of flag refers to
Use this extracted type matcher/coercer with Arguments as well

[x] Create argument class

[x] argument(s) & types

[ ] access arguments as array or hash

[ ] change command class methods flags/arguments so that we can use
these method names in the dsl

[ ] argument validation (arity)

[ ] maybe reverse mount, so you mount a subcommand to a supercommand
    like Root.mount SubCommand instead of SubCommand.mount Root
    or at least SubCommand should be mount_to Root

[ ] flags with = just the same as <SPACE>

[ ] short flag inverts boolean

[ ] combined short flags
