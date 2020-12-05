"
" Alexander Færøy <ahf@0x90.dk>
" PGP: 0x61A208E16E7CB435
"
" Vim Configuration File.
"
" Most recent update: 2020/12/05 23:07:04
"

" I use my name and email for various things throughout the
" configuration file.
let g:name = 'Alexander Færøy'
let g:mail = 'ahf@0x90.dk'

" Make Vim useful by not behaving like Vi.
set nocompatible

" Disable line wrapping.
set nowrap

" Create backup files and store them in ~/.vim/backup/
set backupdir=~/.vim/backup/

" Use a swapfile for our buffers.
set swapfile

" Use ~/.vim/temp/ for swapfile(s).
set directory=~/.vim/temp/

" Allow backspacing over auto-indent, line breaks, and at the start of
" an insert.
set backspace=indent,eol,start

" Use UTF-8 for both the terminal and for file encoding.
set termencoding=utf-8
set encoding=utf-8

" Use UNIX end-lines (\n).
set fileformat=unix

" Use expanded tabs (spaces instead of tabs).
set expandtab

" Use 4 spaces for <Tab>.
set tabstop=4

" Use 4 spaces for <Tab> when auto-indenting.
set shiftwidth=4

" Toggle paste-mode on F10.
set pastetoggle=<F10>

" Highlight matching parenthesis.
set showmatch

" Show the command we are typing.
set showcmd

" Allow hidden buffers.
set hidden

" We are connected to a fast TTY.
set ttyfast

" We also have access to fast scrolling.
set ttyscroll=999

" Always display report.
set report=0

" Execute all macros before updating the screen.
set lazyredraw

" New vertically split windows goes to the right of the current window.
set splitright

" New horizontally split windows goes below of the current window.
set splitbelow

" Do not add an additional space after '.', '?', and '!' when joining.
set nojoinspaces

" Disable modeline-support and use Ciaran's securemodelines plug-in
" instead.
set nomodeline

" Secure Modelines
let g:secure_modelines_verbose = 1
let g:secure_modelines_modelines = 15

" Spelling.
set spelllang=en_us

" Enable the wild menu.
set wildmenu
set wildignore+=*.o,*~
set wildmode=list:longest,full

" Always enable the sign column.
set signcolumn=yes

" Show results as you type your search query.
set incsearch

" Search queries are case insensitive.
set ignorecase

" Search becomes case sensitive if you have an upper case character in
" your search query.
set smartcase

" Show a bit of context when scrolling if possible.
set scrolloff=3
set sidescrolloff=3

" Always show status line.
if has('statusline')
    set laststatus=2

    set statusline=%<%n\ [%f]
    set statusline+=\ [%w%M%H%R%Y]
    set statusline+=\ [%{substitute(getcwd(),\ $HOME,\ '~',\ '')}]
    set statusline+=\ [%{fugitive#head()}]
    set statusline+=%=%-10.(%l,%c%V%)\ %p%%
endif

" Use persistent undo, if it's available.
if has('persistent_undo')
    " Set the undo directory.
    set undodir=~/.vim/undo/

    " Enable undo file.
    set undofile

    " The max. number of changes that can be undone.
    set undolevels=1000

    " The max. number of lines to save for undo when the buffer is
    " reloaded.
    set undoreload=10000
endif

" Enable file-type detection, plug-ins, and auto-indentation.
filetype on
filetype indent on
filetype plugin on

" Let's enable syntax coloring support, but only if Vim is compiled with
" support for it.
if has("syntax")
    " Enable syntax coloring.
    syntax on

    " Enable syntax coloring when printing.
    if has("printer")
        set printoptions+=syntax:y
    endif
endif

" Visualise tabs, trailing spaces, line extensions (wrapped lines), and
" non-breakable space characters. We keep a variant for both terminals
" that support UTF-8 and terminals that lacks UTF-8 support :-(
if (&termencoding == "utf-8") || has("gui_running")
    set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
else
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
endif

if has("gui_running")
    " Enable cursor line when we are in a GUI.
    set cursorline

    " Disable the menu bar.
    set guioptions-=m

    " Disable the toolbar.
    set guioptions-=T

    " Disable left-hand scrollbar.
    set guioptions-=l

    " Disable left-hand scrollbar when there's a vertically split
    " window.
    set guioptions-=L

    " Disable right-hand scrollbar.
    set guioptions-=r

    " Disable right-hand scrollbar when there's a vertically split
    " window.
    set guioptions-=R

    " Enable dark mode (only with GTK).
    if has("gui_gtk")
        set guioptions+=d
    endif

    " Enable mouse support.
    set mouse=a

    " Use popup as mouse-model. See :help mousemodel for an
    " explanation.
    set mousemodel=popup

    " Use Inconsolata as font.
    if hostname() == "hathor"
        set guifont=Inconsolata\ 16
    else
        set guifont=Inconsolata\ 14
    endif
endif

" Function that allows us to specify a set of files where we want
" Vim to update the timestamp of when the file was most recently updated.
function! <SID>UpdateHeaderTimestamp()
    let l:c=col(".")
    let l:l=line(".")
    1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%Y/%m/%d %H:%M:%S")-e
    call cursor(l:l, l:c)
endfunction

" Update the header timestamp for a couple of configuration files.
"   Vim.
autocmd BufWritePre .vimrc      :call <SID>UpdateHeaderTimestamp()
autocmd BufWritePre .vimpagerrc :call <SID>UpdateHeaderTimestamp()

"   Bash.
autocmd BufWritePre .bashrc :call <SID>UpdateHeaderTimestamp()

"   GnuPG.
autocmd BufWritePre dirmngr.conf   :call <SID>UpdateHeaderTimestamp()
autocmd BufWritePre gpg-agent.conf :call <SID>UpdateHeaderTimestamp()
autocmd BufWritePre gpg.conf       :call <SID>UpdateHeaderTimestamp()

"   Git
autocmd BufWritePre .gitconfig     :call <SID>UpdateHeaderTimestamp()
autocmd BufWritePre .gitignore     :call <SID>UpdateHeaderTimestamp()
autocmd BufWritePre .gitattributes :call <SID>UpdateHeaderTimestamp()

"   Dunst
autocmd BufWritePre dunstrc :call <SID>UpdateHeaderTimestamp()

"   X.org
autocmd BufWritePre .xinitrc :call <SID>UpdateHeaderTimestamp()

" Add syntax highlighting of Vim modelines.
try
    autocmd Syntax *
        \ syn match VimModelineLine /^.\{-1,}vim:[^:]\{-1,}:.*/ contains=VimModeline |
        \ syn match VimModeline contained /vim:[^:]\{-1,}:/
    hi def link VimModelineLine comment
    hi def link VimModeline special
catch
endtry

" Switch between header and source files.
let g:switch_header_map = {
            \ 'c':     'h',
            \ 'h':     'c',
            \ 'cc':    'hh',
            \ 'hh':    'cc',
            \ 'cpp':   'hpp',
            \ 'hpp':   'cpp',
            \ 'sig':   'sml',
            \ 'sml':   'sig',
            \ 'erl':   'hrl',
            \ 'hrl':   'erl' }

function! <SID>SwitchTo(f, split) abort
    if ! filereadable(a:f)
        echoerr "File '" . a:f . "' does not exist"
    else
        if a:split
            vne
        endif

        if 0 != bufexists(a:f)
            exec ':buffer ' . bufnr(a:f)
        else
            exec ':edit ' . a:f
        endif
    endif
endfunction

function! <SID>SwitchHeader(split) abort
    let filename = expand("%:p:r")
    let suffix = expand("%:p:e")

    if suffix == ''
        echoerr "Cannot determine header file (no suffix)"
        return
    endif

    let new_suffix = g:switch_header_map[suffix]
    if new_suffix == ''
        echoerr "Don't know how to find the header (suffix is " . suffix . ")"
        return
    end

    call <SID>SwitchTo(filename . '.' . new_suffix, a:split)
endfunction

noremap <Leader>sh  :call <SID>SwitchHeader(0)<CR>
noremap <Leader>ssh :call <SID>SwitchHeader(1)<CR>

" Vim Wiki
let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_hl_headers = 1
let g:vimwiki_listsym_rejected = "✗"
let g:vimwiki_listsyms = " ○◐●✓"
let g:vimwiki_markdown_header_style = 1
let g:vimwiki_markdown_link_ext = 0
let g:vimwiki_toc_header = "Table of Contents"
let g:vimwiki_use_calendar = 1

" Vim Wiki
let wiki = {}
let wiki.name                = "Wiki"
let wiki.path                = "~/wiki/"
let wiki.syntax              = "markdown"
let wiki.ext                 = ".md"
let wiki.index               = "_index"
let wiki.auto_tags           = 1
let wiki.auto_generate_links = 1
let wiki.diary_caption_level = 1
let wiki.diary_rel_path      = "journals"
let wiki.diary_index         = "_index"
let wiki.diary_header        = "Journal Index"
let wiki.auto_diary_index    = 1

let wiki.nested_syntaxes = {
                         \    "python": "python",
                         \    "rust":   "rust",
                         \    "c":      "c",
                         \    "go":     "go"
                         \ }

" Enable our wikis.
let g:vimwiki_list = [wiki]

" Function that allows us to give a set of colorschemes to load and
" stop at the first available colorscheme.
function! <SID>LoadColorScheme(schemes)
    let l:schemes = a:schemes . ":"
    while l:schemes != ""
        let l:scheme = strpart(l:schemes, 0, stridx(l:schemes, ":"))
        let l:schemes = strpart(l:schemes, stridx(l:schemes, ":") + 1)
        try
            exec "colorscheme" l:scheme
            break
        catch
        endtry
    endwhile
endfunction

" We are using a dark background.
set background=dark

" We want the black Inkpot background.
let g:inkpot_black_background = 1

" Load our preferred colorschemes in the defined order.
call <SID>LoadColorScheme("inkpot:night")

" Disable backup of SCM commit message files.
autocmd BufRead svn-commit.tmp setlocal nobackup
autocmd BufRead COMMIT_EDITMSG setlocal nobackup

" Always keep the help window on the top and make <Return> jump to the
" tag under the cursor.
function! <SID>WindowToTop()
    let l:height = winheight(0)
    wincmd K
    execute "resize" l:height
endfunction

" Remove a comment leader when joining lines
set formatoptions+=j

" Don't force #'s to be at column 0.
inoremap # X<BS>#

" Use the mixed menu (buffers, files, etc.)
let g:ctrlp_cmd = 'CtrlPMixed'

" Make Ctrl+t open a new tab.
nmap <C-t> :tabnew<cr>

augroup ahf
    autocmd!

    " Never enable Undo files for files in temporary folders.
    autocmd BufWritePre /tmp/* setlocal noundofile
    autocmd BufWritePre /dev/shm/* setlocal noundofile

    " Make Vim's help system less frustrating to use.
    autocmd FileType help :call <SID>WindowToTop()
    autocmd FileType help nmap <buffer> <Return> <C-]>

    " Enable spell checking and textwidth for emails.
    autocmd FileType mail setlocal nohlsearch spell textwidth=72 formatoptions+=t

    " Enable spell checking for Markdown.
    autocmd FileType markdown setlocal spell

    " Sync syntax for new buffers.
    autocmd BufEnter * syntax sync fromstart

    " When entering a new file, always disable hlsearch.
    autocmd VimEnter * nohlsearch
augroup END

" vim: set sw=4 sts=4 et tw=72 :
