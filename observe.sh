# Observe
#
# Observe files and execute command when files are modified.

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
        echo "Usage: observe [OPTION]... [FILE]..."
        echo
        echo "Observe specified files, or current directory."
        echo
        echo "  -e <command>    Execute command when any observed files are modified"
        echo "  -h              Show this help and exit"
        echo
        return
      ;;
      *)
        FILES="$FILES $1"
      ;;
    esac

    shift
  done

  if [ -z "$FILES" ]; then
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
