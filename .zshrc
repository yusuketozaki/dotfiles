### Q pre block
    [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### aliases
    if [ -f ~/.zsh_aliases ]; then
        source ~/.zsh_aliases
    fi

### ビープ音の停止
    setopt no_beep
    setopt nolistbeep  # 補完時

### Others
    setopt auto_cd  # ディレクトリ名だけで移動する
    setopt no_flow_control  # Ctrl-sとCtrl-qを無効化する
    setopt AUTO_PARAM_KEYS  # 環境変数を補完する

### asdf
    . "$HOME/.asdf/asdf.sh"  # load asdf
    fpath=(${ASDF_DIR}/completions $fpath)  # append completions to fpath
    autoload -Uz compinit && compinit  # initialise completions with ZSH's compinit

### conda
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/yusuke_tozaki/.asdf/installs/python/miniconda3-latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/yusuke_tozaki/.asdf/installs/python/miniconda3-latest/etc/profile.d/conda.sh" ]; then
            . "/Users/yusuke_tozaki/.asdf/installs/python/miniconda3-latest/etc/profile.d/conda.sh"
        else
            export PATH="/Users/yusuke_tozaki/.asdf/installs/python/miniconda3-latest/bin:$PATH"
        fi
    fi
    unset __conda_setup

### Zinit
    if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
        print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
        command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} The clone has failed.%f%b"
    fi

    source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit

    # Load a few important annexes, without Turbo
    # (this is currently required for annexes)
    zinit light-mode for \
        zdharma-continuum/zinit-annex-as-monitor \
        zdharma-continuum/zinit-annex-bin-gem-node \
        zdharma-continuum/zinit-annex-patch-dl \
        zdharma-continuum/zinit-annex-rust

    zinit ice depth=1; zinit light romkatv/powerlevel10k  # enable Powerlevel10k
    zinit light zsh-users/zsh-syntax-highlighting  # enable syntax highlighting

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Q post block
    [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
