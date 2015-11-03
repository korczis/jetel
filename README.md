# jetel

## CLI - Command Line Interface

Run `jetel`

```
tomaskorcak@kx-mac:~/ jetel
NAME
    jetel - Jetel CLI 0.0.1

SYNOPSIS
    jetel [global options] command [command options] [arguments...]

GLOBAL OPTIONS
    --help - Show this message

COMMANDS
    help    - Shows a list of commands or help for one command
    ip, Ip  - Module ip
    modules - Print modules info
    version - Print version info
```

## Executables

### Rake

```
tomaskorcak@kx-mac:~/dev/jetel$ bundle exec rake -T
rake build          # Build jetel-0.0.1.gem into the pkg directory
rake install        # Build and install jetel-0.0.1.gem into system gems
rake install:local  # Build and install jetel-0.0.1.gem into system gems without network access
rake release        # Create tag v0.0.1 and build and push jetel-0.0.1.gem to Rubygems
```
