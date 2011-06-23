# observe

### Bash Function for Observing Files and Executing Command

Utility for executing command when specific files are modified, i.e. running
unit tests.

### Installation

    git clone https://github.com/gnab/observe.git ~/.observe
    echo ". ~/.observe/observe.sh" >> ~/.bashrc

### Usage

    observe [OPTION]... [FILE]...

    Observe specified files, or current directory.

      -e <command>    Execute command when any observed files are modified
      -h              Show this help and exit

### License 

observe is licensed under the MIT license. See LICENCE for further 
details.
