# dotfiles

macOS 用の zsh、Antidote、Starship の設定です。開発ツールの設定は各 Mac の用途に合わせます。

## 含まれる設定

- `.zprofile`：Homebrew の初期化
- `.zshrc`：履歴、補完、zoxide・Starship・mise の初期化
- `.zsh_aliases`：エイリアス
- `.zsh_plugins.txt`：Antidote で使うプラグイン
- `.config/starship.toml`：プロンプト

## 導入

Homebrew が利用できる macOS で、必要なツールを用意します。

```sh
brew install antidote starship zoxide mise uv
git clone https://github.com/yusuketozaki/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./setup.sh
```

既存の設定ファイルがある場合、`setup.sh` は変更せずに停止します。内容を確認したうえで退避して置き換えるには、次を実行します。

```sh
./setup.sh --backup
```

退避先は実行時に表示されます。設定はこのリポジトリへのシンボリックリンクなので、リポジトリの移動・削除をするとリンクが切れます。新しいターミナルを開いて動作を確認してください。Antidote の初回プラグイン取得にはネットワーク接続が必要です。

Starship のアイコンを表示するには、Nerd Font 対応のフォントをターミナルに設定してください。各ツールをインストールしていない場合は、その初期化をスキップします。

## Mac 固有の設定

`~/.zprofile.local` と `~/.zshrc.local` は存在する場合に読み込まれます。個人用のパス、通知先、端末固有の設定はそこに保存してください。このリポジトリには含めません。Kiro CLI などを使う場合は、それぞれのセットアップ方法に従って設定してください。

認証情報はリポジトリに入れず、利用するツールの安全な認証方法に従ってください。`.gitignore` はすでに追跡されているファイルや過去のコミットから情報を消すものではありません。

## AWS の表示

`AWS_PROFILE` を明示したとき、Starship にプロファイル名を表示します。コマンド単位の `--profile` 指定などは検知しません。表示がないことは認証されていないことを意味しません。

## Node.js

mise の導入と Node.js のバージョン指定は別です。各 Mac または各プロジェクトの要件に合わせて設定してください。
