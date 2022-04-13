#
# ~/.profile
#

for path in "$HOME/bin" "$HOME/.local/bin"
do
  if [[ -d "$path" ]]
  then
    PATH="$path:$PATH"
  fi
done
