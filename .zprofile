# Homebrew の場所は Apple silicon と Intel Mac で異なる。
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 端末固有の設定は Git で管理しない。
[[ -r "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
