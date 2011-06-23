# Observe
#
# Execute command when files are modified

# https://gist.github.com/996970

observe()
{
  FILES=""
  while [ $# -gt 0 ]; do
    case $1 in
      "-e")
        if [ $# -lt 2 ]; then
          echo "Missing command after -e parameter."
          return
        fi
        shift
        CMD=$1
        echo "Executing \"$CMD\" when files are modified"
      ;;
      "-h")
        echo
        echo "Observe"
        echo
        echo "Usage:"
        echo "    observe [file] ...                Print file path when files are modified"
        echo "    observe -e <command> [file] ...   Execute command when files are modified"
        echo "    observe -h                        Show this help"
        echo
        return
      ;;
      *)
        FILES="$FILES $1"
      ;;
    esac

    shift
  done

  if [ "$FILES" == "" ]; then
    echo "Observing files in current directory"
  else
    echo "Observing files:"
    for file in $FILES; do
      echo "    $file"
    done
  fi

  NOW=`date`
  while true; do 
    while [ -z `find -L $FILES -type f -newermt "$NOW"` ]; do 
      sleep 1
    done; 
    if [ "$!" != "" ]; then
      kill -0 $! && kill $! && sleep 1
    fi
    echo "CMD = $CMD"
    if [ "$CMD" != "" ]; then
      # TODO: Make background process optional with parameter
      $CMD #&
    else
      # TODO: Print name of file
      echo
    fi
    NOW=`date`
  done
}
