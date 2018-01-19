set nocompatible

" Leader
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on

endif

"""""""""""""""""""""""""""""""""""
"" Plugins
"""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Language plugins
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'evidens/vim-twig'
Plug 'slim-template/vim-slim'

" ruby stuff
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

" A Vim wrapper for running tests on different granularities
Plug 'janko-m/vim-test'

let test#strategy = "dispatch"

" vim-test mappings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Fuzzy finding!
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap <c-p> :FZF<CR>

" theme
Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" helpers for UNIX
Plug 'tpope/vim-eunuch'

" easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

" Easy text exchange operator for Vim
Plug 'tommcdo/vim-exchange'

" " status/tabline
" " makes terminal vim slow :(
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" let g:airline_powerline_fonts = 1

" Snippets!
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine
Plug 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger           = '<tab>'

set runtimepath+=~/.vim/my-snippets/
let g:UltiSnipsSnippetsDir='~/.vim/my-snippets/UltiSnips'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" comment/uncomment with motions
Plug 'tpope/vim-commentary'

" focus events when using iterm2
Plug 'tmux-plugins/vim-tmux-focus-events'

" Perform all vim insert mode completions with Tab
Plug 'ervandew/supertab'

" Insert or delete brackets, parens, quotes in pairs
Plug 'Raimondi/delimitMate'

" Automatically create any non-existent directories before writing the buffer
Plug 'pbrisbin/vim-mkdir'

" Vim alignment plugin
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" wraps and unwraps function arguments, lists, and dictionaries
Plug 'FooSoft/vim-argwrap'

nnoremap <silent> gwr :ArgWrap<CR>
let g:argwrap_padded_braces = '{'

" simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

" move function arguments (and other delimited-by-something items) left and right
" also adds a very useful argument text object
Plug 'AndrewRadev/sideways.vim'

" In pt-pt osx keyboard these are the hjkl mappings for Alt
" <A-j> = ¯
" <A-k> = „
" <A-h> = ˇ
" <A-l> = ‘
"
nnoremap <Left> :SidewaysLeft<cr>
nnoremap <Right> :SidewaysRight<cr>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" Start a * or # search from a visual block
Plug 'bronson/vim-visual-star-search'

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" " Quicker window movement (vim-tmux-navigator already sets this)
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

Plug 'airblade/vim-gitgutter'

" continuously updated session files
Plug 'tpope/vim-obsession'

" Asynchronous Lint Engine
Plug 'w0rp/ale'

let g:ale_fixers = {
      \   'ruby': ['rubocop'],
      \}

" Set this in your vimrc file to disabling highlighting
let g:ale_set_highlights = 0


" tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

let NERDTreeAutoDeleteBuffer=1

" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Numbers
set number
set numberwidth=5

set wildmode=list:longest,list:full

" Use one space, not two, after punctuation.
set nojoinspaces

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1


" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

autocmd Filetype gitcommit setlocal spell textwidth=72

" Remove trailing whitespace on save
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a
    " DCS sequence
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
endif

" reload file when focus gained and save when focus lost
set autoread
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" write and read from the system clipboard
set clipboard^=unnamed,unnamedplus

" equalizes window sizes when Vim is resized
autocmd VimResized * tabdo wincmd =

" other people shouldn't need to know vi to navigate the code
set mouse=a

set nowrap

" highlight current line
set cursorline

" highlight all search matches
set hlsearch

set relativenumber

" consider hyphenated words as words (useful for html)
set iskeyword+=-

set completeopt+=longest,menuone

" avoid scrolling problems
set lazyredraw
" Indicates a fast terminal connection.
set ttyfast

" hides buffers instead of closing them
set hidden

" Always show at least one line above/below the cursor
set scrolloff=2

" Case-insensitive searching.
set ignorecase
" But case-sensitive if expression contains a capital letter.
set smartcase

" kill esc lag
set timeoutlen=1000 ttimeoutlen=0

" enable setting title
set title
" configure title to look like: Vim /path/to/file
set titlestring=Vim:\ %-25.55F\ %a%r%m titlelen=70

" Sometimes setting 'termguicolors' is not enough and one has to set the |t_8f|
" and |t_8b| options explicitly. Default values of these options are
" "^[[38;2;%lu;%lu;%lum" and "^[[48;2;%lu;%lu;%lum" respectively, but it is only
" set when `$TERM` is `xterm`.
" **Need to set it for tmux**
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

" truecolors!
set termguicolors

colorscheme gruvbox
set background=dark

set statusline=%<[%n]\ %{expand('%:h')}/%1*%t%*\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%*

" use tree view in netrw
let g:netrw_liststyle=3

"""
""" My mappings
"""

" Avoid the escape key
inoremap jk <Esc>
cnoremap <silent> jk <Esc>

" quit
nnoremap <leader>q :q<kEnter>

" source
nnoremap <leader>so :so $MYVIMRC<kEnter>

" Search and replace
nnoremap <leader>sr :%s///g<Left><Left>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" kill highlighted search
nnoremap <silent> \ :noh<CR>

" indent after pasting
nnoremap p p=`]`[
nnoremap P P=`]`[
nnoremap ]P P
nnoremap ]p p

" Autoload sessions created by tpope's vim-obsession when starting Vim.
augroup sourcesession
  autocmd!
  autocmd VimEnter * nested
        \ if (!argc() || (argc() == 1 && argv(0) == ".")) && empty(v:this_session) |
        \   if filereadable('Session.vim') |
        \     source Session.vim |
        \   else |
        \     Obsession |
        \   endif |
        \ endif
augroup END

" search word under cursor using fzf's Ag
nnoremap <leader>ag :Ag <C-R><C-W><cr>

" go to horizontal middle of screen
nnoremap zm zszH

" copy filepath to clipboard
nnoremap <leader>pa :let @+ = expand("%")<cr>
" " ----------------------------------------------------------------------------
" " Moving lines (Inpired by junegunn dotfiles)
" " ----------------------------------------------------------------------------
"
" In pt-pt osx keyboard these are the hjkl mappings for Alt
" <A-j> = ¯
" <A-k> = „
" <A-h> = ˇ
" <A-l> = ‘
"
nnoremap <silent> <Up> :move-2<cr>==
nnoremap <silent> <Down> :move+<cr>==
xnoremap <silent> <Up> :move-2<cr>gv=gv
xnoremap <silent> <Down> :move'>+<cr>gv=gv
xnoremap < <gv
xnoremap > >gv

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky (Taken from junegunn dotfiles)
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cWORD>"), 0)<cr>
" nnoremap <leader>! :call <SID>goog(expand("<cWORD>"), 1)<cr>

" ============================================================================
" TEXT OBJECTS
" ============================================================================

" ----------------------------------------------------------------------------
" (Taken from junegunn dotfiles)
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" ?af | entire file (around file)
" ----------------------------------------------------------------------------
xnoremap <silent> af gg0oG$
onoremap <silent> af :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" load local custom vim config if present
let b:thisdir = expand("%:p:h")
let b:vim = b:thisdir . "/.vim.custom"
if (filereadable(b:vim))
  execute "source " . b:vim
endif
