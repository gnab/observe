# observe

### Bash function for observing paths and acting upon file modification.

Utility for observing paths and executing a given command when any files are
modified, i.e. run unit tests.

### Installation

    git clone https://github.com/gnab/observe.git ~/.observe
    echo ". ~/.observe/observe.sh" >> ~/.bashrc

### Usage

    observe [OPTION]... [PATH]...

    Observe specified paths, or current directory.

      -e <command>    Execute command when any files are modified
      -i <filter>     Ignore files matching filter
      -h              Show this help and exit

### License 

observe is licensed under the MIT license. See LICENCE for further 
details.
