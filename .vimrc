" auto reload .vimrc
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" dein
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=/Users/takita/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))

  " プラグインリストを収めたTOMLファイル
  let g:dein_dir = expand('~/.vim/dein')
  let s:toml = g:dein_dir . '/dein.toml'
  let s:lazy_toml = g:dein_dir . '/dein_lazy.toml'

  call dein#begin(expand('~/.vim/dein'), [$MYVIMRC,s:toml])

  " TOMLファイルにpluginを記述
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif


set encoding=utf-8
filetype plugin indent on
syntax enable

" 表示
syntax on "コードの色分け
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
set expandtab "タブ入力を複数の余白入力に置き換える
set shiftwidth=2 "自動インデントでずれる幅
set tabstop=2 "インデントをスペース2つ分に設定
set autoindent "オートインデント
set number "行番号を表示
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set clipboard=unnamed "ヤンクした時にクリップボードに貼る
set display=lastline "1行の文字数に関係なく文字列を表示する
set colorcolumn=80 "80行目に縦線入れる

" 検索
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

" plugin dependencies
"   with syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" その他
set history=5000 "検索履歴数をデフォルト(20件）から1000件にする
set spell "スペルチェック
autocmd BufWritePre * :%s/\s\+$//ge " ファイル保存時に行末の空白を自動削除
autocmd QuickFixCmdPost *grep* cwindow " grep後にquickfix-windowを起動する
