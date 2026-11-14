#!/bin/bash
# 設定をリンクする。既存ファイルはデフォルトでは変更しない。
set -euo pipefail

case "${1-}" in
  '') mode=check ;;
  --backup) mode=backup ;;
  *) printf '使い方: %s [--backup]\n' "$0" >&2; exit 2 ;;
esac
[ "$#" -le 1 ] || { printf '引数が多すぎます\n' >&2; exit 2; }

repo_dir="$(cd -- "$(dirname -- "$0")" && pwd -P)"
files=(.zprofile .zshrc .zsh_aliases .zsh_plugins.txt .config/starship.toml)
conflicts=0
for file in "${files[@]}"; do
  [ -f "$repo_dir/$file" ] || { printf '設定がありません: %s\n' "$file" >&2; exit 1; }
  dest="$HOME/$file"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$repo_dir/$file" ]; then
    continue
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    printf '既存ファイル: %s\n' "$dest"
    conflicts=1
  fi
done
if [ "$conflicts" -eq 1 ] && [ "$mode" = check ]; then
  printf '既存ファイルは変更していません。退避する場合は --backup を付けて再実行してください。\n' >&2
  exit 1
fi

backup_dir=''
if [ "$conflicts" -eq 1 ]; then
  backup_dir="$(mktemp -d "$HOME/dotfiles-backup.XXXXXXXX")"
  printf '退避先: %s\n' "$backup_dir"
fi
for file in "${files[@]}"; do
  dest="$HOME/$file"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$repo_dir/$file" ]; then
    continue
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$(dirname "$backup_dir/$file")"
    mv "$dest" "$backup_dir/$file"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$repo_dir/$file" "$dest"
  printf 'リンク: %s\n' "$dest"
done
