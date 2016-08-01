 " Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if &compatible
   set nocompatible               " Be iMproved
 endif

 set runtimepath^=~/.vim/bundle/neobundle.vim/

 call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

" インストールするプラグインをここに記述
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler' "ファイルをツリー表示
NeoBundle 'alpaca-tc/vim-endwise.git' "Ruby if..end等を自動補完
NeoBundle 'scrooloose/syntastic.git' "syntaxチェッカー
NeoBundle "ctrlpvim/ctrlp.vim" "ファイル検索
NeoBundle 'tell-k/vim-browsereload-mac' "browserのreload
NeoBundle 'nathanaelkane/vim-indent-guides' "インデントの深さを可視化
NeoBundle 'thoughtbot/vim-rspec' "rspec syntax
NeoBundle 'ngmy/vim-rubocop' "rubocop
NeoBundle 'tpope/vim-rails' "rails
NeoBundle 'szw/vim-tags' "ctags

call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

" NeoBundleCheck vim起動時に未インストールのプラグインを通知する

"#####表示設定#####
set encoding=utf-8
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set expandtab "タブ入力を複数の余白入力に置き換える
set shiftwidth=2 "自動インデントでずれる幅
set tabstop=2 "インデントをスペース2つ分に設定
set autoindent "オートインデント
set number "行番号を表示
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set clipboard=unnamed "ヤンクした時にクリップボードに貼る

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

"#####その他#######
set history=1000 "検索履歴数をデフォルト(20件）から1000件にする
set spell "スペルチェック
nnoremap <C-]> g<C-]> " tagsジャンプの時に複数ある時は一覧表示

autocmd BufWritePre * :%s/\s\+$//ge "ファイル保存時に行末の空白を自動削除
autocmd QuickFixCmdPost *grep* cwindow "grep後にquickfix-windowを起動する
