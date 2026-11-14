# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups hist_ignore_space
# タブ間で共有する場合は setopt share_history を有効にする。

# シェルの動作
setopt no_beep no_list_beep auto_cd no_flow_control auto_param_keys

# Antidote（Homebrew で導入）
if (( $+commands[brew] )); then
  _antidote_path="$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
  if [[ -r "$_antidote_path" ]]; then
    source "$_antidote_path"
    antidote load "$HOME/.zsh_plugins.txt"
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
  fi
  unset _antidote_path
fi

[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# Docker の補完。ez-compinit がある場合も明示的に初期化できる。
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
compinit

# uv と uv run のファイル補完
if (( $+commands[uv] )); then
  eval "$(uv generate-shell-completion zsh)"
  _uv_run_mod() {
    if [[ "$words[2]" == "run" && "$words[CURRENT]" != -* ]]; then
      _arguments '*:filename:_files'
    else
      _uv "$@"
    fi
  }
  compdef _uv_run_mod uv
fi

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[mise] )) && eval "$(mise activate zsh)"

# API キーや端末固有の PATH はこのファイルに書かない。
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
