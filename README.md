# observe

### Bash Function for Observing Files and Executing Command

Utility for executing command when specific files are modified, i.e. running
unit tests.

### Installation

    git clone https://github.com/gnab/observe.git ~/.observe
    echo ". ~/.observe/observe.sh" >> ~/.bashrc

### Usage

    observe [file] ...                Print file path when files are modified
    observe -e <command> [file] ...   Execute command when files are modified
    observe -h                        Show this help

### License 

observe is licensed under the MIT license. See LICENCE for further 
details.
