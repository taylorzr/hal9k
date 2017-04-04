### TODO

[ ] flag validation

[ ] argument validation (arity)

[ ] access arguments as array or hash

[ ] flags with = just the same as <SPACE>

[ ] combined short flags

[ ] show help but exit with 1 status when mis-used

[ ] show help and exit with 0 status when help menu called

[ ] capital of short flag boolean should by default invert the boolean, or
at least allow this behavior

[ ] allow configuring a flag to be used multiple times, e.g. ack
    --ignore-directory=foo --ignore-directory=bar
    maybe something like
    module Ack
    module Cli
    flag :ignore_directory, type: String, multiple: true
    flag :ignore_directory, type: String, allow_multiple: true

    or

    flags :ignore_directory, type: String # where the plural of flags would mean it accepts multiple

[ ] consider having Namespace or Group or something in addition to commands
like a command that can't be called

---

### DONE

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

[x] change command class methods flags/arguments so that we can use
these method names in the dsl

[x] ~~maybe reverse mount, so you mount a subcommand to a supercommand
like Root.mount SubCommand instead of SubCommand.mount Root
or at least~~ SubCommand should be mount_to Root

[x] short flag inverts boolean

[x] long boolean "no" prefix, e.g. --no-new-line
