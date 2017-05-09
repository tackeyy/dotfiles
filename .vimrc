" dein.vim

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if &compatible
  set nocompatible
endif

if dein#load_state(expand(s:dein_dir))
  " toms files
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'

  call dein#begin(expand('~/.vim/dein'), [$MYVIMRC,s:toml])

  call dein#load_toml(s:toml)
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

set encoding=utf-8
filetype plugin indent on
syntax enable

" 表示
syntax on                                   " コードの色分け
set title                                   " 編集中のファイル名を表示
set showmatch                               " 括弧入力時の対応する括弧を表示
set expandtab                               " タブ入力を複数の余白入力に置き換える
set shiftwidth=2                            " 自動インデントでずれる幅
set tabstop=2                               " インデントをスペース2つ分に設定
set autoindent                              " オートインデント
set number                                  " 行番号を表示
set smartindent                             " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set clipboard=unnamed                       " ヤンクした時にクリップボードに貼る
set display=lastline                        " 1行の文字数に関係なく文字列を表示する
set cc=81                                   " 81文字目に縦線を入れる "

" 検索
set ignorecase                              " 大文字/小文字の区別なく検索する
set smartcase                               " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan                                " 検索時に最後まで行ったら最初に戻る

" その他
set history=5000                            " 検索履歴数をデフォルト(20件）から1000件にする
set visualbell t_vb=                        " ビープ音すべてを無効にする
set noerrorbells                            " エラーメッセージの表示時にビープを鳴らさない
set nobackup                                " ファイル保存時にバックアップファイルを作らない
set noswapfile                              " ファイル編集中にスワップファイルを作らない
set autoread                                " 外部でファイルに変更がされた場合は読みなおす
autocmd QuickFixCmdPost *grep* cwindow      " grep後にquickfix-windowを起動する
autocmd BufWritePre * :%s/\s\+$//ge         " ファイル保存時に行末の空白を自動削除

" --------------------------------
" Shougo/unite.vim
" --------------------------------
let g:unite_enable_start_insert=1

nmap <Space> [unite]

" プロジェクト内でバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>UniteWithProjectDir<Space>buffer file_mru<CR>

" unite grep に ag を使用
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" --------------------------------
" Shougo/vimfiler.vim
" --------------------------------
nnoremap <silent> <Space>vf  :VimFiler<CR>

" --------------------------------
" syntastic
" --------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntasticmodemap = { 'mode': 'active', 'active_filetypes': [
  \ 'ruby', 'javascript','coffee', 'scss', 'html', 'haml', 'slim', 'sh',
  \ 'spec', 'vim', 'zsh', 'sass', 'eruby'] }

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_ruby_checkers = ['rubocop']

let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

" -------------------------------
" soramugi/auto-ctags.vim
" -------------------------------
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']

" -------------------------------
" ctrlp.vim
" -------------------------------
let g:ctrlp_use_caching=0
let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'

" --------------------------------
" neocomplete.vim
" --------------------------------
let g:acp_enableAtStartup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" --------------------------------
" vim-monster
" --------------------------------
" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" With neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" --------------------------------
" neosnippet.vim
" --------------------------------
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" --------------------------------
" vim-airline
" --------------------------------
set laststatus=2
let g:airline#extensions#syntastic#enabled = 1

" --------------------------------
" alvan/vim-closetag
" --------------------------------
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb"

" --------------------------------
" iberianpig/tig-explorer.vim
" --------------------------------
nnoremap <Space>t :TigOpenProjectRootDir<CR>

" --------------------------------
" vim-browsereload-mac
" --------------------------------
nnoremap <Space>r :ChromeReload<CR>

" --------------------------------
" mxw/vim-jsx
" --------------------------------
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
