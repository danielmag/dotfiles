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

" Fuzzy finding!
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
nnoremap <c-p> :FZF<CR>

" theme
Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

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
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

set runtimepath+=~/.vim/my-snippets/
let g:UltiSnipsSnippetsDir='~/.vim/my-snippets/UltiSnips'

" git integration
Plug 'tpope/vim-fugitive'

" comment/uncomment with motions
Plug 'tpope/vim-commentary'


" plugin for intelligently toggling line numbers
Plug 'myusuf3/numbers.vim'
" focus events when using iterm2
Plug 'tmux-plugins/vim-tmux-focus-events'

" Perform all vim insert mode completions with Tab
Plug 'ervandew/supertab'

" Insert or delete brackets, parens, quotes in pairs
Plug 'jiangmiao/auto-pairs'

" Automatically create any non-existent directories before writing the buffer
Plug 'pbrisbin/vim-mkdir'

" Vim alignment plugin
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" simplifies the transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

" Start a * or # search from a visual block
Plug 'bronson/vim-visual-star-search'

" dont repeat basic movement keys
Plug 'takac/vim-hardtime'

let g:hardtime_default_on = 1

" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" " Quicker window movement (vim-tmux-navigator already sets this)
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

Plug 'airblade/vim-gitgutter'

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

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-test mappings
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_eruby_ruby_quiet_messages =
"     \ {"regex": "possibly useless use of a variable in void context"}

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





" Remove trailing whitespace on save
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
autocmd BufWritePre * :call TrimWhitespace()

" reload file when focus gained and save when focus lost
set autoread
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

set clipboard^=unnamed,unnamedplus " write and read from the system clipboard

autocmd VimResized * tabdo wincmd = " equalizes window sizes when Vim is resized

set nowrap

set cursorline                      " highlight current line
set hlsearch                        " highlight all search matches

set relativenumber

set iskeyword+=-                    " consider hyphenated words as words

set completeopt+=longest,menuone

set lazyredraw                      " avoid scrolling problems
set ttyfast                         " Indicates a fast terminal connection.

set hidden                          " hides buffers instead of closing them

set scrolloff=2                     " Always show at least one line above/below the cursor

set ignorecase                      " Case-insensitive searching.
set smartcase                       " But case-sensitive if expression contains a capital letter.

set title                                          " enable setting title
set titlestring=Vim:\ %-25.55F\ %a%r%m titlelen=70 " configure title to look like: Vim /path/to/file

set background=dark " Theme
colorscheme base16-default

set statusline=%<[%n]\ %{expand('%:h')}/%1*%t%*\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

let g:netrw_liststyle=3 " use tree view in netrw

"""
""" My mappings
"""

" Avoid the escape key
inoremap jk <Esc>

" Disable relative numbers in command mode
" mapping Esc key causes a lot of issues, so i'm using jk which is probably
" better anyway
nnoremap : :set norelativenumber<CR>:redraw<CR>:
cnoremap <silent> <CR> <CR>:set relativenumber<CR>
cnoremap <silent> jk <Esc>:set relativenumber<CR>
cnoremap <silent> <C-c> <C-c>:set relativenumber<CR>

" write
nnoremap <leader>w :w<kEnter>
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
nnoremap <silent> § :noh<CR>

" indent after pasting
nnoremap p p=`]`[
nnoremap P P=`]`[
nnoremap ]P P
nnoremap ]p p

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
nnoremap <silent> ¯ :move+<cr>==
nnoremap <silent> „ :move-2<cr>==
nnoremap <silent> ˇ <<
nnoremap <silent> ‘ >>
xnoremap <silent> ¯ :move'>+<cr>gv=gv
xnoremap <silent> „ :move-2<cr>gv=gv
xnoremap <silent> ˇ <gv
xnoremap <silent> ‘ >gv
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
