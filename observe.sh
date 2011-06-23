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

  # TODO: Do the actual observe of files and execute on modify
}
