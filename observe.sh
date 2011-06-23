# Observe
#
# Utility for observing paths and run a given command when any oberved files
# are modified, i.e. run unit tests.
#
# Implemented by Ole Petter Bang <olepbang@gmail.com>

observe()
{
  PATHS=""
  while [ $# -gt 0 ]; do
    case $1 in
      "-e")
        if [ $# -lt 2 ]; then
          echo "Missing command after -e parameter."
          return
        fi
        shift
        CMD=$1
        echo "Executing \"$CMD\" when any files are modified"
      ;;
      "-h")
        echo "Usage: observe [OPTION]... [PATH]..."
        echo
        echo "Observe specified paths, or current directory."
        echo
        echo "  -e <command>    Execute command when any files are modified"
        echo "  -h              Show this help and exit"
        echo
        return
      ;;
      *)
        PATHS="$PATHS $1"
      ;;
    esac

    shift
  done

  if [ -z "$PATHS" ]; then
    echo "Observing current directory"
  else
    echo "Observing paths:"
    for path in $PATHS; do
      echo "    $path"
    done
  fi

  NOW=`date`
  while true; do 
    while [ -z `find -L $PATHS -type f -newermt "$NOW"` ]; do 
      sleep 1
    done; 
    if [ -n "$!" ]; then
      kill -0 $! && kill $! && sleep 1
    fi
    if [ -n "$CMD" ]; then
      # TODO: Make background process optional with parameter
      $CMD #&
    else
      # TODO: Print name of file
      echo
    fi
    NOW=`date`
  done
}
