# jetel

## CLI - Command Line Interface

Run `jetel`

```
$ jetel
NAME
    jetel - Jetel CLI 0.0.5

SYNOPSIS
    jetel [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help - Show this message

COMMANDS
    config     - Show config
    help       - Shows a list of commands or help for one command
    ip, Ip     - Module ip
    modules    - Print modules info
    nga, Nga   - Module nga
    sfpd, Sfpd - Module sfpd
    version    - Print version info
```

## Structure

```
.
├── bin
├── lib
│   └── jetel
│       ├── cli
│       │   └── cmd
│       ├── config
│       ├── downloader
│       │   └── backends
│       ├── etl
│       ├── extensions
│       ├── helpers
│       ├── jetel
│       └── modules
│           ├── ip
│           ├── nga
│           └── sfpd
├── pkg
└── test
```

## Examples

**Plays nicely with [csv2psql](https://github.com/korczis/csv2psql)**

### Rake

```
tomaskorcak@kx-mac:~/dev/jetel$ bundle exec rake -T
rake build          # Build jetel-0.0.1.gem into the pkg directory
rake install        # Build and install jetel-0.0.1.gem into system gems
rake install:local  # Build and install jetel-0.0.1.gem into system gems without network access
rake release        # Create tag v0.0.1 and build and push jetel-0.0.1.gem to Rubygems
```
