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

      "-b")
        BG="1"
      ;;

      "-f")
        FILE="1"
      ;;

      "-i")
        if [ $# -lt 2 ]; then
          echo "Missing filter after -i parameter."
          return
        fi
        shift
        IGNORE=$1
        echo "Ignoring files matching filter \"$IGNORE\""
      ;;

      "-h")
        echo "Usage: observe [OPTION]... [PATH]..."
        echo
        echo "Observe specified paths, or current directory."
        echo
        echo "  -e <command>    Execute command when any files are modified"
        echo "  -b              Execute the command in background (needs -e)"
        echo "  -f              Execute the command on each changed file (needs -e)"
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

  HIDEERROR=" 2>&1 /dev/null"
  FIND="find -L $PATHS -type f -newermt"
  NOW=`date`

  while true; do

    while true; do
      if [ -n "$IGNORE" ]; then
        MODIFIED=`$FIND "$NOW" -not -name "$IGNORE"`
      else
        MODIFIED=`$FIND "$NOW"`
      fi

      if [ -n "$MODIFIED" ]; then
        break
      fi
      sleep 1
    done

    if [ -n "$!" ]; then
      kill -0 $! $HIDEERROR && kill $! $HIDEERROR && sleep 1
    fi

    if [ -n "$CMD" ]; then
      if [ -n "$BG" ]; then
        if [ -n "$FILE" ]; then
          for file in $MODIFIED; do
            $CMD $file &
          done
        else
          $CMD &
        fi
      fi
      if [ -n "$FILE" ]; then
        for file in $MODIFIED; do
          $CMD $file
        done
      else
        $CMD
      fi
    else
      for file in $MODIFIED; do
        echo $file
      done
    fi

    sleep 1
    NOW=`date`
  done
}
