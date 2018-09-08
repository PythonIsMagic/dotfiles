" Note: The folds for .vimrc start closed by default
" Open all folds: <Leader>o  (I set ',' as my Leader key)
" Close all folds: <Leader>c
" Toggle a fold: <Space>

" Vundle Plugins 
" ##########################################################################################
set nocompatible				" Must be 1st, changes other options.
								" Avoid conflict between system-wide and local vimrc files
filetype off					" Required.

" set Runtime path to inc Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim/
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
Plugin 'roktas/syntastic-more'
Plugin 'vim-scripts/ShowMarks'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
" Plugin 'skammer/vim-css-color'
Plugin 'ap/vim-css-color'
Plugin 'uguu-org/vim-matrix-screensaver'

call vundle#end()				" End of plugin config
filetype plugin indent on

" Bufferline ------------------{{{ 
" ##########################################################################################

" super simple vim plugin to show the list of buffers in the command bar
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_solo_highlight = 1
" }}}
" CtrlP Config ------------------{{{ 
" ##########################################################################################
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
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py|venv'

" Search from Home dir 
noremap <Leader>` :CtrlP ~<CR>
" }}}
" CtrlP-funky ------------------{{{
" navigates and jumps to function def from the current file w/o ctags. 
" It just searches for function definitions or equivalent lines using regular expressions
" Mapping:
nnoremap <Leader>f :CtrlPFunky<Cr>
"
" NERDTree/NERDCommenter 

" }}}
" EasyMotion ------------------{{{ 
" ##########################################################################################

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
" }}}
" Emmet ------------------{{{ 
" ##########################################################################################

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
" }}}
" Fugitive  ------------------{{{ 
" ##########################################################################################

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
" }}}
" GUndo ------------------{{{ 
" ASCII undo tree. view the tree of changes, navigate it, diff and revert 
nnoremap U :GundoToggle<CR>

" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
" }}}
" InterestingWords ------------------{{{ 
" ##########################################################################################

" This lets us highlight multiple terms in different colors
nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
nnoremap <silent> <leader>z :call UncolorAllWords()<cr>
let g:interestingWordsRandomiseColors = 1
" }}}
" Lightline ------------------{{{ 
" ##########################################################################################

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
" }}}
" NERDCommenter ------------------{{{ 
" ##########################################################################################
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
" }}}
" NERDTree ------------------{{{ 
" ##########################################################################################
" Map the tilde key to toggle NERDTree
nnoremap ` :NERDTreeToggle<CR>  
let NERDTreeShowHidden=1		" Show hidden files
let NERDTreeShowBookmarks=1		" Show NERDTree bookmarks by default
let NERDTreeIgnore=['\\.pyc', '\\\~$', '\\.swo$', '\\.swp$', '\\.git', '\\.hg', '\\.svn', '\\.bzr']
" }}}
" PythonMode ------------------{{{ 

"---- Configure Rope 
" ##########################################################################################

" Ignore annoying errors
" E131: continuation line unaligned for hanging indent [pep8] 
" W0401: Wildcard import %s
" E265: Block comment should start with '# '
" E501: Line too long
" E116: invalid args?
" let g:pymode_lint_ignore = "E116,E131,E265,E501,W0401,"
let g:pymode_lint_ignore = "E501"
" }}}
" Showmarks ------------------{{{ 
" ##########################################################################################

" Seems to show a lot of extra stuff in .vimrc.
" Cutdown on what marks it shows
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Don't leave on by default, use :ShowMarksOn to enable
" let g:showmarks_enable = 1

" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=White

" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=White

" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow

" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
" }}}
" Surround ------------------{{{ 
" ##########################################################################################

" Quoting/parenthesizing/bracketing help.
" cs'" == change surrounding ' to "
" ds" == delete surrounding "
" dst == delete surround tags (HTML)
" ysw" == surround the word with "
" ysW" == surround the WORD with "
" or visually select and use S" to surround with "
" Note: Always use the ending bracket (ex: )]}>) to close the space off.
" }}}
" Syntastic ------------------{{{ 
" ##########################################################################################
" Run :SyntasticInfo to see what's going on.
" run checkers explicitly by calling :SyntasticCheck <checker>. 

" Checkers:
" http://jshint.com/install/
" sudo npm install -g csslint
" Syntastic-extras adds checkers for: C, C++, cfg/dosini, GNU Make, JSON, Python, YAML

let g:syntastic_css_checkers = ['csslint']
let g:syntastic_html_tidy_exec = 'tidy'
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck', 'sh']

"If you want to hide all warnings for any "ng-*" attributes, you may do
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

let g:syntastic_html_tidy_ignore_errors = ["trimming empty", "proprietary attribute"]
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
" }}}
" TagList ------------------{{{ 
" ##########################################################################################

" Functions/Source Browser
nnoremap <Leader>t :TlistToggle<CR>

let Tlist_Show_One_File = 1		" Only show tags for current buffer
let Tlist_Exit_OnlyWindow = 1	" Exit if taglist is last window open
" }}}
" Vim-Endwise ------------------{{{ 
" ##########################################################################################
" }}}

