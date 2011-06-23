# Observe
#
# Utility for observing paths and executing a given command when any files are
# modified, i.e. run unit tests.
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
      "-i")
        if [ $# -lt 2 ]; then
          echo "Missing filter after -i parameter."
          return
        fi
        shift
        IGNORE="-not -name $1"
        echo "Ignoring files matching filter \"$1\""
      ;;
      "-h")
        echo "Usage: observe [OPTION]... [PATH]..."
        echo
        echo "Observe specified paths, or current directory."
        echo
        echo "  -e <command>    Execute command when any files are modified"
        echo "  -i <filter>     Ignore files matching filter"
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
    while true; do
      MODIFIED=`find -L $PATHS -type f -newermt "$NOW" $IGNORE`
      if [ -n "$MODIFIED" ]; then
        break
      fi
      sleep 1
    done
    if [ -n "$!" ]; then
      kill -0 $! && kill $! && sleep 1
    fi
    if [ -n "$CMD" ]; then
      # TODO: Make background process optional with parameter
      $CMD #&
    else
      for file in $MODIFIED; do
        echo $file
      done
    fi
    sleep 1
    NOW=`date`
  done
}
