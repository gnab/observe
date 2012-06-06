observe
=========
### Bash function for observing paths and acting upon file modification.

Utility for observing paths and/or executing a given command when any files are
modified, i.e. run unit tests.

### Installation ###
```bash
    git clone https://github.com/gnab/observe.git ~/.observe
    echo ". ~/.observe/observe.sh" >> ~/.bashrc
```

### Usage ###
```
    observe [OPTION]... [PATH]...

    Observe specified paths, or current directory.

      -e <command>    Execute command when any files are modified
      -b              Execute the command in background (needs -e)
      -f              Execute the command on each changed file (needs -e)
      -i <filter>     Ignore files matching filter
      -h              Show this help and exit

```

### Examples ###
```bash
    # run "rake" when non-"*.swp" files in current directory are modified
    observe -e rake -i "*.swp"
```

```bash
    # show the current number of lines in a text file, when it's changed
    observe -e "wc -l " -f "*.txt"
```

### License ###

observe is licensed under the MIT license. See LICENCE for further
details.
