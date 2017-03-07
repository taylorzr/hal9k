[x] cascading flags (still need tests)
[x] default root command/namespace that can be overidden
[ ] think about starting a command instead of setting root and starting
hal9k. this would easily allow cli's to be reused. not sure why you
might need this but maybe useful during refactoring, say you wanted
to extract a command. you could easily use just that command by just
yea, then could do Heroku::Cli.start
and if you had multiple cli's in a project, you would need this anywho
starting hal9k with it.
[ ] flags with = just the same as <SPACE>
[ ] short flag inverts boolean
[ ] combined short flags
[ ] argument validation (arity)
