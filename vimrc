"
" Alexander Færøy <ahf@0x90.dk>
"
" Most recent update: Fri 26 Dec 2008 22:19:38 CET
"
syntax on
set nocompatible
set wildmenu
set wildignore+=*.o,*~,.lo
set nowrap
set ruler
set bs=2
set backup
set backupdir=~/.vim/backup/
set swapfile
set directory=~/.vim/temp/
set history=150
set ruler
set noinsertmode
set nonumber
set incsearch
set showmatch
set path=.,~/
set undolevels=1000
set updatecount=100
set ttyfast
set ttyscroll=999
set report=0
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set enc=utf-8
set tenc=utf-8
set fileformat=unix
set showmatch
set mat=5
set novisualbell
set noerrorbells
set backspace=indent,eol,start
set whichwrap+=<,>,[,]
set lazyredraw
set nofoldenable
set autoread
set makeef=error.err
set showfulltag
set pastetoggle=<F10>
set expandtab
set laststatus=2

let g:name = 'Alexander Færøy'
let g:mail = 'ahf@0x90.dk'

if has("syntax")
    set syntax=on
    set popt+=syntax:y
endif

if has("eval")
    filetype on
    filetype indent on
    filetype plugin on
endif

if has("spell")
    function! Spell(dict)
        let dict = a:dict

        if &spell != 1
            setlocal spell
            set spelllang=".dict
        else
            setlocal nospell
        endif
    endfunction
endif

if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

nmap <C-t>  :tabnew<cr>
nmap <C-p>  :ha<cr>

if &term =~ "xterm"
    if has('title')
        set title
    endif
endif

if has("gui_gtk")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    set gfn=Terminus\ 8
    set mousemodel=popup
endif

if has("eval")
    fun! LoadColourScheme(schemes)
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
    endfun

    if has('gui')
        call LoadColourScheme("inkpot:night:rainbow_night:darkblue:elflord")
    else
        if has("autocmd")
            autocmd VimEnter *
                        \ if &t_Co == 88 || &t_Co == 256 |
                        \     call LoadColourScheme("inkpot:darkblue:elflord") |
                        \ else |
                        \     call LoadColourScheme("darkblue:elflord") |
                        \ endif
        else
            if &t_Co == 88 || &t_Co == 256
                call LoadColourScheme("inkpot:darkblue:elflord")
            else
                call LoadColourScheme("darkblue:elflord")
            endif
        endif
    endif
endif

if "" == &shell
    if executable("/bin/bash")
        set shell=/bin/bash

        if has("eval")
            let is_bash=1
        endif
    elseif executable("/bin/zsh")
        set shell=/bin/zsh
    endif
endif

if has("eval") && has("autocmd")
    function! <SID>check_pager_mode()
        if exists("g:loaded_less") && g:loaded_less
            set laststatus=0
            set ruler
            set foldmethod=manual
            set foldlevel=99
            set nolist
        endif
    endfunction

    autocmd VimEnter * :call <SID>check_pager_mode()
endif

if has("eval")
    function! <SID>UpdateRcHeader()
        let l:c=col(".")
        let l:l=line(".")
        1,10s-\(Most recent update:\).*-\="Most recent update: ".strftime("%c")-e
        call cursor(l:l, l:c)
    endfun

    function! <SID>UpdateCopyrightHeaders()
        let l:a = 0
        for l:x in getline(1, 10)
            let l:a = l:a + 1
            if -1 != match(l:x, 'Copyright (c) [- 0-9,]*200[4567] ' . g:name)
                if input("Update copyright header? (y/N) ") == "y"
                    call setline(l:a, substitute(l:x, '\(200[4567]\) Alexander', '\1, 2008 Alexander', ""))
                endif
            endif
        endfor
    endfun

    function! CleverTab()
        if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
            return "\<Tab>"
        else
            return "\<C-P>"
        endif
    endfun

    function! MakeGenericCopyrightHeader()
        0 put ='# Copyright (c) '.strftime('%Y').' '.g:name.' <'.g:mail.'>'
        put ='# Distributed under the terms of the GNU General Public License v2'
        $
    endfun

    function! MakeChangeLogEntry()
        norm gg
        /^\d
        norm 2O
        norm k
        call setline(line("."), strftime("%Y-%m-%d") .
                    \ " " . g:name . " <" . g:mail . ">")
        norm 2o
        call setline(line("."), "\t* ")
        norm $
        r! svn status | grep -v '^?' | sed -e 's,^D, -,' | cut -d\  -f2- | 
                \ sort | sed -e 's,^\s*\(\([+-]\)\s*\)\?\(\S*\)\s*$,\2\3\,,' -e 's, \+, ,g'
                \ -e '$s~,$~:~' | fmt -w2000
        norm kJ
        star!
    endfun

    function! IncludeGuardText()
        let l:t = substitute(expand("%"), "[./]", "_", "g")
        return toupper("GUARD_" . l:t)
    endfun

    function! MakeIncludeGuards()
        norm gg
        /^$/
        norm 2O
        call setline(line("."), "#ifndef " . IncludeGuardText())
        norm o
        call setline(line("."), "#define " . IncludeGuardText() . " 1")
        norm G
        norm o
        call setline(line("."), "#endif")
    endfun

    function! FileTime()
        let ext=tolower(expand("%:e"))
        let fname=tolower(expand('%<'))
        let filename=fname . '.' . ext
        let msg=""
        let msg=msg." ".strftime("(Modified %b,%d %y %H:%M:%S)",getftime(filename))

        return msg
    endfun

    function! CurrentTime()
        let ftime=""
        let ftime=ftime." ".strftime("%b,%d %y %H:%M:%S")

        return ftime
    endfun

    noremap <Leader>cl :call MakeChangeLogEntry()<CR>
    noremap <Leader>ig :call MakeIncludeGuards()<CR>
    inoremap <Tab>   <C-R>=CleverTab()<CR>
    inoremap <S-Tab> <Tab>

    if v:version >= 700
        let g:switch_header_map = {
                    \ 'cc':    'hh',
                    \ 'hh':    'cc',
                    \ 'c':     'h',
                    \ 'h':     'c',
                    \ 'cpp':   'hpp',
                    \ 'hpp':   'cpp' }

        function! SwitchTo(f, split) abort
            if ! filereadable(a:f)
                echoerr "File '" . a:f . "' does not exist"
            else
                if a:split
                    new
                endif

                if 0 != bufexists(a:f)
                    exec ':buffer ' . bufnr(a:f)
                else
                    exec ':edit ' . a:f
                endif
            endif
        endfun

        function! SwitchHeader(split) abort
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

            call SwitchTo(filename . '.' . new_suffix, a:split)
        endfun

        noremap <Leader>sh  :call SwitchHeader(0)<CR>
        noremap <Leader>ssh :call SwitchHeader(1)<CR>
    endif
endif

if has("autocmd")
    au FileType ruby
        \ set softtabstop=2 |
        \ set shiftwidth=2 |
        \ set tabstop=2 |

    autocmd BufEnter *
        \ if &filetype == "cpp" |
        \   set noignorecase |
        \ else |
        \   set ignorecase |
        \ endif

    autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
    autocmd BufWritePre *bashrc :call <SID>UpdateRcHeader()

    autocmd FileType mail,human set nohlsearch formatoptions+=t textwidth=72 spell spelllang=en nonu
    autocmd FileType css set smartindent
    autocmd FileType html,css set noexpandtab tabstop=2

    autocmd BufRead svn-commit.tmp :setlocal nobackup

    autocmd BufWritePre * call <SID>UpdateCopyrightHeaders()
endif

if (&termencoding == "utf-8") || has("gui_running")
    if v:version >= 700
        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif

if has("unix")
    if !isdirectory(expand("~/.vim/"))
        !mkdir -p ~/.vim/backup/
        !mkdir -p ~/.vim/temp/
    endif
endif

if filereadable("/usr/share/dict/words")
    set dictionary=/usr/share/dict/words
endif

iabbrev xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

iabbrev #p #!/usr/bin/perl
iabbrev #e #!/usr/bin/env
iabbrev #r #!/usr/bin/ruby
iabbrev #b #!/bin/bash

iabbrev monday      Monday
iabbrev tuesday     Tuesday
iabbrev wednesday   Wednesday
iabbrev thursday    Thursday
iabbrev friday      Friday
iabbrev saturday    Saturday
iabbrev sunday      Sunday

let g:c_gnu=1
let g:c_no_curly_error=1
let html_number_lines=1
let html_use_css=1
let use_xhtml=1
let perl_extended_vars=1
let apache_version="2.0"
let g:load_doxygen_syntax=1
let g:doxygen_end_punctuation='[.?]'

highlight Pmenu guibg=brown gui=bold

noremap <F7>  :make<cr>

let g:explVertical=1
let g:explWinSize=35
let g:explSplitLeft=1
let g:explSplitBelow=1
let g:explDetailedHelp=0

set laststatus=2
set statusline=
set statusline+=%n\
set statusline+=%f\
set statusline+=\[%{strlen(&ft)?&ft:'none'},
set statusline+=%{&encoding},
set statusline+=%{&fileformat}]
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %<%P

if has("eval") && has("autocmd")
    function! <SID>abbrev_cpp()
        iabbrev <buffer> jin #include
        iabbrev <buffer> jde #define
        iabbrev <buffer> jci const_iterator
        iabbrev <buffer> jcl class
        iabbrev <buffer> jco const
        iabbrev <buffer> jdg \ingroup
        iabbrev <buffer> jdx /**<CR><CR>/<Up>
        iabbrev <buffer> jrd /*<CR><CR>/<Up>
        iabbrev <buffer> jit iterator
        iabbrev <buffer> jns namespace
        iabbrev <buffer> jpr protected
        iabbrev <buffer> jpu public
        iabbrev <buffer> jpv private
        iabbrev <buffer> jsl std::list
        iabbrev <buffer> jsm std::map
        iabbrev <buffer> jss std::string
        iabbrev <buffer> jsv std::vector
        iabbrev <buffer> jsp std::tr1::shared_ptr
        iabbrev <buffer> jty typedef
        iabbrev <buffer> jun using namespace
        iabbrev <buffer> jvi virtual
        iabbrev <buffer> jst static
        iabbrev <buffer> jt1 std::tr1
    endfunction

    function! <SID>abbrev_php()
        iabbrev <buffer> jcl class
        iabbrev <buffer> jfu function
        iabbrev <buffer> jco const
        iabbrev <buffer> jpr protected
        iabbrev <buffer> jpu public
        iabbrev <buffer> jpv private
        iabbrev <buffer> jst static
        iabbrev <buffer> jdx /**<CR><CR>/<Up>
        iabbrev <buffer> jrd /*<CR><CR>/<Up>
        iabbrev <buffer> jin include
    endfunction

    function! <SID>abbrev_ruby()
        iabbrev <buffer> jcl class
        iabbrev <buffer> jmo module
        iabbrev <buffer> jin require
        iabbrev <buffer> jdx #<CR><CR><Up>
    endfunction

    function! <SID>abbrev_c()
        iabbrev <buffer> jin #include
        iabbrev <buffer> jde #define
        iabbrev <buffer> jco const
        iabbrev <buffer> jdx /**<CR><CR>/<Up>
        iabbrev <buffer> jst static
    endfunction

    augroup abbreviations
        autocmd!
        autocmd FileType cpp  :call <SID>abbrev_cpp()
        autocmd FileType php  :call <SID>abbrev_php()
        autocmd FileType ruby :call <SID>abbrev_ruby()
        autocmd FileType c    :call <SID>abbrev_c()
    augroup END
endif

if has("autocmd")
    augroup content
        autocmd!

        autocmd BufNewFile *.rb 0put ='# vim: set sw=2 sts=2 et tw=80 :' |
            \ 0put ='#!/usr/bin/env ruby' |
            \ 2put ='' |
            \ set sw=2 sts=2 et tw=80 |
            \ norm G

        autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ call MakeIncludeGuards() |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.h 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
            \ call MakeIncludeGuards() |
            \ set sw=4 sts=4 et foldmethod=syntax |
            \ norm G

        autocmd BufNewFile *.exheres-* call MakeGenericCopyrightHeader() |
            \ set nu
            \ norm g
    augroup END
endif

if has("autocmd")
    au VimEnter * nohls
endif

" vim: set sw=4 sts=4 et tw=140 :
