" File: .vimrc
" Author: Erik Lunna
" Description: The VIM config file.
" Date Started: 12-20-2015

" ============================================================================
" Plugins
" ============================================================================
" Vundle Config
set nocompatible				" Must be 1st, changes other options.
								" Avoid conflict between system-wide and local vimrc files
filetype off					" Required.

" set Runtime path to inc Vundle and initialize
set runtimepath+=~/.vim/bundle/vundle/
call vundle#begin()

" (note: older versions of Vundle used Bundle instead of Plugin)

Plugin 'gmarik/vundle'  " let Vundle manage Vundle
Plugin 'Lokaltog/vim-distinguished'
Plugin 'nanotech/jellybeans.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/taglist.vim'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'lfv89/vim-interestingwords'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'klen/python-mode'
Plugin 'bling/vim-bufferline'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/syntastic'
Plugin 'myint/syntastic-extras'

call vundle#end()				" End of plugin config
filetype plugin indent on


" Auto-resource when we save.
" :source ~/.vimrc
autocmd! bufwritepost .vimrc source %

set encoding=utf8				" Important for Python 3
set title			            " Sets the terminal title to the current file
set laststatus=2                " Always show status line.
set history=1000		        " We like a big history.
set undolevels=100              " We like a big undo history
set number			            " Line numbers
set tabstop=4                   " How many spaces a tab counts for.
set softtabstop=4				" Number of spaces in the tab when editing. Spaces inserted
								" when you <TAB> and spaces removed when you backspace.
set autoindent					" Copies indentation from previous line
set scrolloff=8                 " Vertical lines above/below when scrolling 
set nostartofline               " try to preserve column where cursor is positioned.


set textwidth=92			    " Make standard width 80
set formatoptions-=t            " Don't auto-wrap lines when typing
set cursorline                  " Highlight the line the cursor is on.
highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
set colorcolumn=+1				" Display column at end of textwidth value.
highlight ColorColumn ctermbg=233  " Gray column

highlight OverLength ctermbg=red ctermfg=white guibg=#592929 " Color long lines
match OverLength /\%93v.\+/ " When to start highlight overlength 

set shiftwidth=4                " Affects >>, <<, ==, and auto indentation.
set shiftround                  " When at 3 spaces and I hit >>, go to 4, not 5.
vnoremap < <gv					" better left indentation
vnoremap > >gv					" better right indentation

" Setup Leader Keys
let mapleader=","               " Use comma for default Leader
let maplocalleader = "\\"		" Use \ for the secondary(local) Leader

" Less chording
nnoremap ; :

" ##############################################################################
" Search and highlighting
set hlsearch					" Highlight search terms
set incsearch			        " Find the next match as we type the search
set ignorecase					" Ignore case when searching
set smartcase			        " When searching try to be smart about cases
set showmatch					" cursor briefly shows matching brace when inserted
set matchtime=3                 " To speed things up
set lazyredraw					" Redraw screen only when we need to.
set wildmenu                    " Provides scrollable graphical menu for autocompletion.
set wildmode=list:longest       " Behave similarly to a shell,

"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*.a,*.pyc,*~
set wildignore+=*vim/backups*,log/**,tmp/**,venv/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.png,*.avi,*.mkv,*.so


" Clear the screen of any highlighting.
nnoremap <BS> :nohl<CR>

" Keep search matches in the middle of the window and pulse the line when moving
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<c-o>

" Same with jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" ##############################################################################
" Buffer/file settings
set autochdir                   " Vim changes to folder of the file in buffer.
set autoread                    " Reload files changed outside vim"
set hidden                      " you can change buffers without saving
" Disable unnecessary backups
" They trigger too many events for file system watchers
set nobackup                    " Turn off backups
set nowritebackup               " Turn off backups
set noswapfile                  " Turn off backups
set nowb                        " Turn off backups
set backupskip=/tmp/*,/private/tmp/*" # To save crontab edits from exploding.
autocmd FocusLost * :wa			" Save when losing focus

"set clipboard+=unnamed			" share windows clipboard; better copy and paste
                                " Alias the 'anonymous' register to * register
" To see if there is clipboard support
" $ vim --version | grep clipboard

" Maps Ctrl+S to save file
inoremap <C-s> <C-o>:w<CR>
nnoremap <C-s> :w<CR>

" ##############################################################################
" Navigation Shortcuts
" Change windows using Control+Direction (hjlk)
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Resize the current window
nmap <C-Up> :resize +1<CR>
nmap <C-Down> :resize -1<CR>

" ^RIGHT & ^LEFT: next and previous buffers
nmap <C-Right> :bn<CR>
nmap <C-Left> :bp<CR>

" Mimic Firefox tab navigation
nnoremap <C-t> :tabnew<CR>
inoremap <C-t> <Esc>:tabnew<CR>
nnoremap <Leader><Tab> :tabnext<CR>
inoremap <Leader><Tab> <Esc>:tabnext<CR>i
nnoremap <Leader><S-Tab> :tabprevious<CR>
inoremap <Leader><S-Tab> <Esc>:tabprevious<CR>i

" Easy splits or tabs.
" nnoremap <C-i> :vnew<CR>
" inoremap <C-i> <Esc>:vnew<CR>
nnoremap <C-o> :vnew<CR>
inoremap <C-o> <Esc>:vnew<CR>

" Set where splits go and focus on them immediately.
set splitbelow                  " splits go below w/focus
set splitright                  " vsplits go right w/focus

" Auto-jump to the end of the pasted text:
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" Yank from the cursor to the end of the line
nnoremap Y y$

" Remap 0 to beginning of line-text.
nnoremap 0 ^

" Maps space to fold/unfold
nnoremap <space> za

" Quit window
noremap <Leader>e :quit<CR>
" Quit ALL windows (no save)
noremap <Leader>E :qa!<CR>

" <F1> to prompt for a help topic
nnoremap <F1> :help<Space>
onoremap <F1> <C-C>:help<Space>
vnoremap <F1> <C-C>:help<Space>
map! <F1> <C-C><F1>

" Toggle relative numbering vs absolute numbering.
nnoremap # :set relativenumber!<CR>

" Reformat the current paragraph/selected
nnoremap Q gqap
vnoremap Q gq

" Change case
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

" Easy open vimrc
nnoremap <Leader>ov :vsplit $MYVIMRC<CR>

" Paste formatting toggling
set pastetoggle=<F8>			" Needed if autoindent is on 

"Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    autocmd!
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" CSS Alphabetizer
nmap <F4> :g#\({\n\)\@<=#.,/}/sort<CR>
" g        " Work over the whole file running .,/}/sort on each line that matches
"          " the pattern \({\n\)\@<=
" #...#... " Delimiters: first bit is search pattern, second bit is what
"          " to do on each matching line
" \(       " Grouping, containing:
"   {\n    " Open brace followed by new line
" \)       " End of grouping
" \@<=     " Negative look-behind, so match after the new-line, but make sure that
"          " the match point is preceded by an open brace and a new-line
" 
" .,/}/    " From this line to the next closing brace...
" sort     " Sort the lines

" ##############################################################################
" Plugin Configuration
" ##############################################################################
" ==================== CtrlP
" ---- Commands
" Ctrl-D: switch to filename only search instead of full path.
" Ctrl-R: switch to regexp mode.
" Ctrl-F or Ctrl-B: cycle between modes.: 
" Ctrl-T: Open file in new tab
" Ctrl-V: Open file in vertical split
" F5: Clear cache

let g:ctrlp_match_window = 'top,order:ttb' " ttb = order matching files top to bottom
let g:ctrlp_switch_buffer = 0		" Always open files in new buffers
let g:ctrlp_show_hidden	= 1			" Lets ctrlp show hidden files

let g:ctrlp_working_path_mode = 0	" Let's us change working dir during a session
" let g:ctrlp_working_path_mode =- 'ra'

" Hide unnecessary files from search
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

" Search from Home dir 
noremap <Leader>` :CtrlP ~<CR>

" ==================== CtrlP-funky
" navigates and jumps to function def from the current file w/o ctags. 
" It just searches for function definitions or equivalent lines using regular expressions
" Mapping:
nnoremap <Leader>f :CtrlPFunky<Cr>

" ==================== NERDTree
" Map the tilde key to toggle NERDTree
nnoremap ` :NERDTreeToggle<CR>  
let NERDTreeShowHidden=1		" Show hidden files
let NERDTreeShowBookmarks=1		" Show NERDTree bookmarks by default

" ==================== NERDCommenter
" <Leader>ci == Comment line(s)
" <Leader>cn == Nested Comment 
" <Leader>cs == Sexy Comments (Looks good for python!)
" <Leader>cm == Multiline Comment (use for Python doc-comments)
" <leader>c$ - Comments from cursor to EOL.
" <leader>cA - Append comment to the EOL

" let g:NERDUsePlaceHolders=0
" let g:NERDAllowAnyVisualDelims=1
let g:NERDSpaceDelims=1			" Set the space after a comment char to 0
" let g:NERDCompactSexyComs = 1 " for prettified multi-line comments

let g:NERDCustomDelimiters = {'python': { 'left': '#', 'leftAlt': '"""', 'rightAlt': '"""' }}

" ==================== Emmet
" Pumping out made HTML/CSS
" Expansion shortcut: <C-Y>,
" Update tags: <C-y>u
" Remove tag: <C-y>k
" Make anchor from URL: <C-y>a
" Make quoted text from URL: <C-y>A
" Prettify code: <C-y>c
" Lorem ipsum: div>lorem and <C-y>,
" HTML template: html:5
" There is also html:4s (strict)
" There is also html:xt (xhtml)
" link:css: <link rel="stylesheet" href="style.css" />
" img:srcset, img:s --> <img srcset="" src="" alt="" />

" Nesting: 
"	> child
"	+ Sibling
"	^ Climb-up (opposite of child)
"	* Multiplication  (ex: li*5 makes 5 <li> tags)
"	() Grouping

" Multiple classes???

" Attribute operators
" . class (can string together class1.class2.etc)
" # id
" [] custom attributes  (ex: td[title="Hello world!" colspan=3])
" $ number (Use with multiplcation to number lists, can pad too $$ $$$)
" @ number origin and dir

" Test: a{click me} == <a href="">click me</a>

" Note: In many cases you can skip typing tag names and just get a div by default
" This works for .content, .wrapper, #id

" CSS Support! Lots of shortcuts!

" ==================== Surround
" Quoting/parenthesizing/bracketing help.
" cs'" == change surrounding ' to "
" ds" == delete surrounding "
" dst == delete surround tags (HTML)
" ysw" == surround the word with "
" ysW" == surround the WORD with "
" or visually select and use S" to surround with "
" Note: Always use the ending bracket (ex: )]}>) to close the space off.

" ==================== TagList
" Functions/Source Browser
nnoremap <Leader>t :TlistToggle<CR>

let Tlist_Show_One_File = 1		" Only show tags for current buffer
let Tlist_Exit_OnlyWindow = 1	" Exit if taglist is last window open

" ==================== GUndo
" ASCII undo tree. view the tree of changes, navigate it, diff and revert 
nnoremap U :GundoToggle<CR>

" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ==================== Fugitive
" Git wrapper
" Common commands
" Gstatus
" Gcommit
" Gmove and Gremove
" Ggrep
" Glog
" Gbrowe - open the current file on github
" Examples:
" :Git checkout -b experimental

" the % symbol has a special meaning: expands to the full path of the current file.
" use this to run any git cmd that expects a filepath as an arg, making the cmd act on 
" the current file.

" convenience methods
" :Gwrite		== :Git add %
" :Gread		== :Git checkout %
" :Gremove		== :Git rm %
" :Gmove		== :Git mv %

" ==================== InterestingWords
" This lets us highlight multiple terms in different colors
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>z :call UncolorAllWords()<cr>
let g:interestingWordsRandomiseColors = 1

" ==================== EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " You can type target keys more lazily.
let g:EasyMotion_do_shade = 1

" Nice motions using Tab and the native movement keys
nmap <Tab>h <Plug>(easymotion-b)
nmap <Tab>j <Plug>(easymotion-j)
nmap <Tab>k <Plug>(easymotion-k)
nmap <Tab>l <Plug>(easymotion-w)

" s for "search"
nmap <Leader>s <Plug>(easymotion-s)
nmap <Leader><Leader>s <Plug>(easymotion-s2)

" ==================== PythonMode
" Trims whitespace by default.
" Default bindings
" <Leader>r runs python code
" <Leader>b add/remove breakpoint (ipdb)
" K - search python documentation
" <C-Space> autocompletes
" [[ jump to prev class/func
" ]] jump to next class/func

" Run :PymodeTroubleshooting to see configuration details 

" ---- Configure pymode
let g:pymode_python = 'python'	" Default to python2
let g:pymode_doc = 1			" Enable pymode doc lookup
let g:pymode_folding = 0		" Don't autofold code
let g:pymode_virtualenv = 1		" Support virtualenv
let g:pymode_lint_on_fly = 0	" Check code on-the-fly
let g:pymode_lint_message = 1	" Show err msg if cursor place on err line

" Problem: .ropeproject is created in home dir or big projects dir. Slows down regenerate
" and autocomplete.
" Solution: Create an empty directory without write permission in ~. Script this in
" dotfiles?
" $ mkdir ~/.ropeproject && chmod 000 $_

" ---- Configure Rope
let g:pymode_rope = 1
let g:pymode_rope_lookup_project = 0	" Look in parents for rope project
let g:pymode_rope_goto_definition_bind = '<Leader>g'
let g:pymode_rope_regenerate_on_write = 1 " If modified

" Extended autocompletion for objects which have not been imported
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_goto_def_newwin = "new"

" Renaming/refactoring
let g:pymode_rope_rename_bind = '<LocalLeader>r'
let g:pymode_rope_rename_module_bind = '<LocalLeader>m'
let g:pymode_rope_organize_imports_bind = '<LocalLeader>o'

" Getting autoimport to work - so far not working
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_bind = '<LocalLeader>i'
let g:pymode_rope_autoimport_import_after_complete = 1	" Import after autocomplete
" nnoremap <LocalLeader>i :RopeAutoImport<CR>

" Ignore annoying errors
let g:pymode_lint_ignore = "E116,E265,E501,W0401"
" W0401: Wildcard import %s
" E265: Block comment should start with '# '
" E501: Line too long
" E116: invalid args?

" ==================== Bufferline
" super simple vim plugin to show the list of buffers in the command bar
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_solo_highlight = 1


" ==================== Lightline
" Very lightweight tabline.
" For powerline fonts: 
" https://powerline.readthedocs.io/en/latest/installation/linux.html#font-installation
" wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
" wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
" mv PowerlineSymbols.otf ~/.fonts/
" fc-cache -vf ~/.fonts/
" mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

" Configure GUI Options
set guifont=Inconsolata

" colorscheme distinguished
colorscheme jellybeans 

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [
      \             [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename'],
      \     ],
      \    'right': [
      \         ['lineinfo'],
      \         ['percent'],
      \         ['fileformat', 'fileencoding', 'filetype']
      \     ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


" ==================== Syntastic
" Syntax checking hacks for vim
" Run :SyntasticInfo to see what's going on.
" run checkers explicitly by calling :SyntasticCheck <checker>. 

" Checkers:
" http://jshint.com/install/
" sudo npm install -g csslint

let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_html_checkers = ['tidy']
" let g:syntastic_html_checkers = ['tidy', 'w3']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_css_checkers = ['csslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" By default syntastic doesn't fill the |location-list| with the errors found by the checkers,
" tells syntastic to update the |location-list| automatically.
let g:syntastic_always_populate_loc_list = 1

" 0: err window is neither auto opened nor closed.
" 1: err window is auto opened when errors are detected, closed when none are detected.
" 2: err window ia auto closed when no errors are detected, but not auto opened 
let g:syntastic_auto_loc_list = 1

" run syntax checks when buffers are first loaded, as well as on saving:
let g:syntastic_check_on_open = 1

" Don't check when quitting vim
let g:syntastic_check_on_wq = 0

" ##############################################################################
" Filetype Settings

" Text Files
au BufEnter *.txt setlocal textwidth=60 wrap linebreak nolist fo=aw2tq

" autocmd BufNewFile,BufRead *.html set filetype=htmldjango

" ##############################################################################
" Python Specific Stuff

" Easy django/python syntax 
nnoremap <Leader>5 i{%  %}<Left><Left><Left>
inoremap <Leader>5 {%  %}<Left><Left><Left>
iabbrev ifname if __name__ == "__main__":
iabbrev {{ {{ }}<Left><Left><Left>


" ============================================================================
" Todo List
" ============================================================================
" Marks a todo as done and moves it to the completed list.
" Requires /todo directory
" Requires todo.txt, completed.txt

nnoremap <Leader><Leader>d :.s/todo/ done/<CR> 0"=strftime("%m-%d-%y")<CR>P0vg_x:redir >> ~/Documents/dotfiles/todo/completed.txt<CR>:echon @"<CR>:redir END<CR>dd:nohl<CR>


" Getting python3 support
" https://github.com/vim/vim
" http://stackoverflow.com/questions/30444890/vim-use-python3-interpreter-in-python-mode
