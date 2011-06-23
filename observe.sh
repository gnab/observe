# Observe
#
# Execute command when files are modified

# https://gist.github.com/996970

observe()
{
  if [ $# -lt 1 ]; then
    observe help
    return
  fi
  case $1 in
    "help")
      echo
      echo "Observe"
      echo
      echo "Usage:"
      echo "    observe file ... [command]"
      echo
    ;;
    *)
      echo "TODO: Parse command line and start observing"
    ;;
  esac
}
