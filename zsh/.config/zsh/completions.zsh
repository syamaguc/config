#!/bin/sh

# completions
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# 補完候補をそのまま探す -> 小文字を大文字に変えて探す -> 大文字を小文字に変えて探す
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
### 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''

### 補完侯補をメニューから選択する。
### select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:default' menu select=2
zmodload zsh/complist

# compinit
_comp_options+=(globdots)		# Include hidden files.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload history-search-end


