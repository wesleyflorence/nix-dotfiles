# Find File
ff() {
  if [[ -d $1 ]]; then
    cd $1
  else
    nvim $1
  fi
}

# Find Project
fp() {
  cd $(fd -H --no-ignore-vcs -t d '.git$' ~/code | sed 's/.\{5\}$//' | fzf --height 40% --reverse)
}


# Open NixPkg Search Web
function nix-search-web() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: search_nixos_package <package_name>"
    return 1
  fi

  local package_name="$1"
  local url="https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=${package_name}"

  # Use the 'open' command on MacOS, 'xdg-open' for Linux, 'start' on Windows
  if [[ "$OSTYPE" == "darwin"* ]]; then
    open "$url"
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    python3 -m webbrowser "$url"
  elif [[ "$OSTYPE" == "cygwin"* ]] || [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32"* ]]; then
    start "$url"
  else
    echo "Platform not supported"
    return 1
  fi
}
