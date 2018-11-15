" Author: Erik Lunna
" Date Started: 12-20-2015

" ###################################
" Vim Settings 
" ###################################
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
set scrolloff=5                 " Vertical lines above/below when scrolling 
set sidescrolloff=5				" Horizontal lines beside when scrolling. Useful with nowrap.
set nostartofline               " try to preserve column where cursor is positioned.

set textwidth=92			    " Make standard width 80
set formatoptions-=t            " Don't auto-wrap lines when typing
set cursorline                  " Highlight the line the cursor is on.
highlight CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
set colorcolumn=+1				" Display column at end of textwidth value.
highlight ColorColumn ctermbg=233  " Gray column
" highlight Cursor guibg=#626262
highlight Cursor guibg=white

highlight OverLength ctermbg=red ctermfg=white guibg=#592929 " Color long lines
match OverLength /\%93v.\+/ " When to start highlight overlength 

set shiftwidth=4                " Affects >>, <<, ==, and auto indentation.
set shiftround                  " When at 3 spaces and I hit >>, go to 4, not 5.
vnoremap < <gv					" better left indentation
vnoremap > >gv					" better right indentation

" set spell spelllang=en_us		" Check spelling in comments.

" Searching/highlighting
set hlsearch					" Highlight search terms
set incsearch			        " Find the next match as we type the search
set ignorecase					" Ignore case when searching
set smartcase			        " When searching try to be smart about cases
set showmatch					" cursor briefly shows matching brace when inserted
set matchtime=3                 " To speed things up
set lazyredraw					" Redraw screen only when we need to.
set wildmenu                    " Provides scrollable graphical menu for autocompletion.
set wildmode=list:longest       " Behave similarly to a shell,

" Set where splits go and focus on them immediately.
set splitbelow                  " splits go below w/focus
set splitright                  " vsplits go right w/focus

"stuff to ignore when tab completing
set wildignore=*.o,*.obj,*.a,*.pyc,*~
set wildignore+=*vim/backups*,log/**,tmp/**,venv/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.png,*.avi,*.mkv,*.so

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

" ###################################
" Mappings and shortcuts 
" ###################################

" Setup Leader Keys
let mapleader=","               " Use comma for default Leader
let maplocalleader = "\\"		" Use \ for the secondary(local) Leader

" Less chording
nnoremap ; :

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

" Maps Ctrl+S to save file
inoremap <C-s> <C-o>:w<CR>
nnoremap <C-s> :w<CR>

" Space toggles individual folds
nnoremap <Space> za
vnoremap <Space> zf

" Close all folds/groups
nmap <Leader>c zM
" Open all folds/groups
nmap <Leader>o zR

" Auto-jump to the end of the pasted text:
vnoremap y y`]
vnoremap p p`]
nnoremap p p`]

" Yank from the cursor to the end of the line
nnoremap Y y$

" Remap 0 to beginning of line-text.
nnoremap 0 ^

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
nnoremap <Leader>ov :tabnew $MYVIMRC<CR>

" Paste formatting toggling
set pastetoggle=<F8>			" Needed if autoindent is on 


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

" ###################################
" Window & Buffer navigation bindings 
" ###################################
" Change windows using Control+Direction (hjlk)
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
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

" Resize the current window
nmap <C-Up> :resize +1<CR>
nmap <C-Down> :resize -1<CR>

" Quit window
noremap <Leader>e :quit<CR>
" Quit ALL windows (no save)
noremap <Leader>E :qa<CR>

" ###################################
" Filetypes and Autocmds 
" ###################################

autocmd FileType txt setlocal textwidth=60 wrap linebreak nolist fo=aw2tq
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" autocmd BufNewFile,BufRead *.html set filetype=htmldjango

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0
augroup END

" Auto-resource when we save.
" :source ~/.vimrc
autocmd! bufwritepost .vimrc source %

"Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    autocmd!
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

" ###################################
" Abbreviaions 
" ###################################
" http://vim.wikia.com/wiki/Auto_spelling_correction_using_abbreviations
" iabbrev int he in the

" ###################################
" Python Specific 
" ###################################
"
" Easy django/python syntax 
nnoremap <Leader>5 i{%  %}<Left><Left><Left>
inoremap <Leader>5 {%  %}<Left><Left><Left>
iabbrev ifname if __name__ == "__main__":
iabbrev {{ {{ }}<Left><Left><Left>
" Todo List  
" Marks a todo as done and moves it to the completed list.
" Requires /todo directory
" Requires todo.txt, completed.txt

nnoremap <Leader><Leader>d :.s/todo/ done/<CR> 0"=strftime("%m-%d-%y")<CR>P0vg_x:redir >> ~/Documents/dotfiles/todo/completed.txt<CR>:echon @"<CR>:redir END<CR>dd:nohl<CR>

" Toggle Syntastic checking
nnoremap <LocalLeader>s :SyntasticToggleMode<CR>
onoremap <LocalLeader>s :SyntasticToggleMode<CR>

" Source the plugins
source $HOME/Documents/dotfiles/plugins.vim
