### Flag variation

argv =[
  '-f', 'some_flag_value',     # flag with value separated by space
   '-fsome_flag_value',        # flag with value no separation
   '-f=some_flag_value',       # equals separation
   '--flagsome_value',         # long no separation
   '--complex-flagsome_value', # multiple word flag no separation
   '--flag', '--some-other-flag'
]


# Help menu methods

use   'echo [string to echo]'
short 'Echo anything to the screen'
long  'Echo is for echoing anything back to the screen'
flag  :newline, :n, type: Boolean, default: false, scope: :local # Local default? yea probably; Boolean or :boolean?

flag :market,   :m, options: ['US', 'UK'], default: nil
flag :revision, :r # Default type to string
flag :revision, :r, type: :string
flag :ignore_unreleasable_revision, type: :boolean, default: false


### THOR example

desc          'announce_release', 'Get most recent releasable sha'
method_option :market, aliases: '-m', enum: %w(US UK), required: true
method_option :revision, aliases: '-r'
method_option :ignore_unreleasable_revision, type: :boolean, default: false

