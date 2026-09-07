#!/usr/bin/env bash
# Show cht.sh results in this window, with no shell evaluation of user input.
set -euo pipefail
selected=$(cat "$HOME/.tmux-cht-languages" "$HOME/.tmux-cht-command" | fzf) || exit 0
[[ -n $selected ]] || exit 0
read -r -p "Enter Query: " query || exit 0

urlencode() {
    local LC_ALL=C text=$1 char hex i
    for ((i=0; i<${#text}; i++)); do
        char=${text:i:1}
        case "$char" in
            [a-zA-Z0-9.~_-]) printf '%s' "$char" ;;
            *) printf -v hex '%%%02X' "'$char"; printf '%s' "$hex" ;;
        esac
    done
}
topic=$(urlencode "$selected")
encoded_query=$(urlencode "$query")
if grep -Fqx -- "$selected" "$HOME/.tmux-cht-languages"; then
    url="https://cht.sh/$topic/$encoded_query"
else
    url="https://cht.sh/$topic~$encoded_query"
fi
curl --fail --silent --show-error --connect-timeout 10 --max-time 60 "$url" | less -R
