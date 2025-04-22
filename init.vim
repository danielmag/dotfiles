" Leader
let mapleader = " "

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
"
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
"
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" persist undos
if !isdirectory($HOME."/.vim/undo-dir")
  call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"""""""""""""""""""""""""""""""""""
"" Plugins
"""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

" Language plugins
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'

Plug 'udalov/kotlin-vim'

" ruby stuff
Plug 'tpope/vim-rails'

" projectionist.vim: Granular project configuration. Very useful for alternating
" between test and main file
Plug 'tpope/vim-projectionist'

" asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'

let g:dispatch_quickfix_height = 25
let g:dispatch_tmux_height = 25


" A Vim wrapper for running tests on different granularities
Plug 'janko-m/vim-test'

" vim-test mappings
nmap <silent> <leader>t :w<CR>:TestNearest<CR>
nmap <silent> <leader>T :w<CR>:TestFile<CR>
nmap <silent> <leader>l :w<CR>:TestLast<CR>

let test#strategy = "neovim"

" Fuzzy finding!
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>

" search word under cursor using fzf's Rg
nnoremap <leader>rg :Rg <C-R><C-W><cr>

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? copilot#Accept("<TAB>") :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <leader>cc  <Plug>(coc-codeaction-source)

" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

" Neovim plugin for GitHub Copilot
Plug 'github/copilot.vim'

let g:copilot_no_tab_map = v:true

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

" git integration
Plug 'tpope/vim-fugitive'

command! Gblame :Git blame
command! Gbrowse :GBrowse

Plug 'tpope/vim-rhubarb'

vnoremap <silent><leader>gb :GBrowse<cr>

" comment/uncomment with motions
Plug 'tpope/vim-commentary'

" focus events when using iterm2
Plug 'tmux-plugins/vim-tmux-focus-events'

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
let g:argwrap_tail_comma = 1

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

" tree explorer plugin for vim
Plug 'scrooloose/nerdtree'

let NERDTreeAutoDeleteBuffer=1


Plug 'editorconfig/editorconfig-vim'

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Search Dash.app from Vim
Plug 'rizzatti/dash.vim'

nmap <leader>d <Plug>DashSearch

Plug 'svermeulen/vim-subversive'

" s for substitute
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

" Substitute Over Range Motion
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" Integration with abolish.vim
nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)

nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)

let g:subversivePromptWithCurrent = 1

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

set synmaxcol=1000

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

" ignore node modules when completing words
set wildignore+=**/node_modules/**

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1


" Switch between the last two files
nnoremap <leader><leader> <c-^>

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

autocmd Filetype gitcommit setlocal spell textwidth=72

" Remove trailing whitespace on save
fun! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun
autocmd BufWritePre * :call TrimWhitespace()

fun! SaveIfModified()
  if getbufinfo('%')[0].changed
    :w
  endif
endfun

" reload file when focus gained and save when focus lost
set autoread
au FocusGained,BufEnter * :checktime
au FocusLost,WinLeave,BufLeave * :call SaveIfModified()
au FocusLost,WinLeave,BufLeave * :CocCommand eslint.executeAutofix

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
" set lazyredraw
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

" truecolors!
set termguicolors

colorscheme gruvbox
set background=dark

set statusline=%<[%n]\ %{expand('%:h')}/%1*%t%*\ %m%r%y\ %=%-14.(%l,%c%V%)\ %P
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
nnoremap <silent> ; :noh<CR>

" indent after pasting
nnoremap p p=`]`[
nnoremap P P=`]`[
nnoremap ]P P
nnoremap ]p p

" create commit message from branch name
nnoremap <leader>cm /branch<CR>wyg_ggP:s/-/ /g<CR>dawgUl:noh<CR>

" quick window navigation from terminal windows
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" import
nnoremap <leader>im ojkpbbbyiwIimport jkpa from 'jkwcf/:jkAjkbhC'jk:w<CR>

" go to insert mode when entering terminal windows
:au BufEnter * if &buftype == 'terminal' | :startinsert | endif

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

" go to horizontal middle of screen
nnoremap zm zszH

" copy filepath to clipboard
nnoremap <leader>pa :let @+ = expand("%")<cr>
" copy filename to clipboard
nnoremap <leader>fn :let @+ = expand('%:t:r')<cr>
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

nnoremap <leader>? :call <SID>goog(expand("<C-R><C-W>"), 0)<cr>
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

function! GetFullClassNameFn()
  " Save some registers
  let l:r_a = @a
  let l:r_b = @b

  " save cursor position and shit
  let l:winview = winsaveview()
  " Start at the top of the file
  :0
  " Search for the first "class" occurence
  /class
  " Get the class string into the register a
  normal! W"ayW

  let class_name = @a
  let previous_line = line('.')
  ?module
  let current_line = line('.')
  while previous_line > current_line
    normal! W"byW
    let class_name = '::' . class_name
    let class_name = @b . class_name

    let previous_line = line('.')
    ?module
    let current_line = line('.')
  endwhile

  " Restore registers
  let @a = l:r_a
  let @b = l:r_b

  " restore cursor position and shit
  call winrestview(l:winview)

  return class_name
endfunction

nnoremap <silent> <leader>cn :let @+ = GetFullClassNameFn()<cr>

" load local custom vim config if present
let b:thisdir = expand("%:p:h")
let b:vim = b:thisdir . "/.vim.custom"
if (filereadable(b:vim))
  execute "source " . b:vim
endif

" this needs to be at end for some reason
let test#javascript#jest#executable = 'yak script jest'
let test#javascript#jest#file_pattern .= '|(variations\.tsx)'
