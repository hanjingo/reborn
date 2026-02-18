" 一些基本的vim知识

"键绑定
"   nore:表示非递归;
"   map:普通模式按键; 
"   vmap:虚拟模式按键; 
"   imap:插入模式按键; 
"   umap:删除某个映射;

" --------------------------------------------------------------

" ---------------常规配置-------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" 设置主题配色
syntax enable
set t_co=256
set t_ut=
colorscheme codedark

" 不要显示那个乌干达儿童提示
set shortmess=atI

" 高亮显示当前行
set cursorline

" 行号
set number

" 自动换行
set wrap
set linebreak
set wrapmargin=1

" 语法高亮
set syntax=on

" 自动缩进
set autoindent
set cindent

" utf8编码
set enc=utf-8

" 中文
set langmenu=zh_CN.UTF-8

" 拼写检查
set nospell
set spelllang=en_us
autocmd FileType markdown,txt,gitcommit setlocal spell   " 只在markdown、txt、gitcommit文件中启用拼写检查

" 自动补全限制
set completeopt=menu,menuone,noselect

" 空闲等待时间
set updatetime=300

" 搜索模式忽略大小写
set ignorecase

" 搜索时高亮匹配结果
set hlsearch

" 设置自动保存
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHoldI", "CompleteDone"]

" 显示当前模式
set showmode

" 显示cmd
set showcmd

" 自动检测外部更改
set autoread

" 设置自动切换工作目录
set autochdir

" 共享剪切板
set clipboard+=unnamed

" 不要备份(慎重考虑)
"set nobackup

" 不要交换文件(慎重考虑)
"set noswapfile

" 处理未保存或只读文件时,弹出确认
set confirm

" 使用鼠标
set mouse=a

" 安静模式
set noerrorbells " 出错时，别发声
set visualbell   " 出错时，屏幕闪烁
" --------------------------------------------------------------


" ----------------按键设置--------------------------------------
" 设置backspace键盘
set backspace=2

" 设置tab键
set tabstop=4	  " tab长度
set softtabstop=4 " 编辑模式时按<-键回退的长度
set shiftwidth=4  " 每级缩进长度
set expandtab     " tab自动替换程空格

" 插入模式移动 
inoremap <C-k> <up>
inoremap <C-j> <down>
inoremap <C-h> <left>
inoremap <C-l> <right>

" 插入模式自动补全
"inoremap ( ()<esc>i
"inoremap [ []<esc>i
"inoremap { {}<esc>i
"inoremap ' ''<esc>i

" 插入模式的撤销
inoremap <C-u> <esc>u

" 保存数据
inoremap <C-s> <esc>:w!<cr>li
noremap <C-s> <esc>:w!<cr>

" 保存并退出
inoremap <C-q> <esc>:wq!<cr>
noremap <C-q> <esc>:wq!<cr>

" 设置 F3 打开终端(位于右下角)
noremap <F3> :bot term ++rows=20 <cr>
" --------------------------------------------------------------


" ---------------------个性化配置 ------------------------------
" 定义设置文件头
autocmd BufNewFile *.h,*.hpp exec ":call SetTitle()"
func SetTitle()
    call setline(1, "/*************************************************************************") 
    call append(line("."), "* Copyright (C) ".strftime("%Y") ." ==HE HANJING== All rights reserved.")
    call append(line(".")+1, "* File Name: ".expand("%")) 
    call append(line(".")+2, "* Author: HE HANJING") 
    call append(line(".")+3, "* Mail: hehehunanchina@live.com ") 
    call append(line(".")+4, "* Created Time: ".strftime("%c")) 
    call append(line(".")+5, "************************************************************************/") 
    call append(line(".")+6, "")
 
    " go文件引入包名
    if &filetype == 'go'
       "call append(line(".")+7, "package ") 
    endif
    " 新建文件后,自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc


" 状态栏配置
set laststatus=2 " 0：不显示状态行；1：仅当窗口多于一个时，显示状态行；2：总是显示状态行

" 设置状态行格式: 
"   %F 完整路径
"   %m 如果缓冲区已修改则标识为[+]
"   %r 如果缓冲区只读则标识为[RO]
"   %h 如果是帮助缓冲区则标识为[Help]
"   %w 如果为预览窗口则标识为[Preview]
"   %l 行号
"   %v 列号
"   %p 文件所在行的百分比
set statusline=%F%m%r%h%w\ pos(%l/%L,%v)%p%%\ %{strftime(\"%H:%M:%S\")}

" 每秒刷新状态栏（更新时间）
if has('timers')
    function! StatusLineTimer(timer)
        execute 'let &stl=&stl'
    endfunction
    let timer = timer_start(1000, 'StatusLineTimer', {'repeat': -1})
endif


" 光标始终保持屏幕中间
"if !exists('g:rc_always_center')
"    let g:rc_always_center = 1
"else
"    if g:rc_always_center == 0 | augroup! rc_always_center | endif
"endif

"augroup rc_always_center
"    autocmd!
"    autocmd VimEnter,WinEnter,VimResized * call RCAlwaysCenterOrNot()
"augroup END

"function! RCAlwaysCenterOrNot()
"    if g:rc_always_center
"        let &scrolloff = float2nr(floor(winheight(0) / 2) + 1)
"        inoremap <CR> <CR><C-o>zz
"    else
"        let &scrolloff = 0
"        silent! iunmap <CR>
"    endif
"endfunction


" 打开URL
"if has('macunix')
"  let g:open_browser_cmd = 'open'
"elseif has('unix')
"  let g:open_browser_cmd = 'xdg-open'
"elseif has('win32')
"  let g:open_browser_cmd = 'start'
"endif
"nnoremap <leader>ob :execute '!' . g:open_browser_cmd . ' ' . expand('<cfile>')<CR>
" --------------------------------------------------------------




" ------------------------配置第三方插件 -----------------------
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'                    " go支持
Plugin 'rust-lang/rust.vim'              " rust支持
Plugin 'majutsushi/tagbar'               " 标签栏
Plugin 'scrooloose/nerdtree'             " 文件浏览器
Plugin 'Xuyuanp/nerdtree-git-plugin'     " 文件浏览器git支持
Plugin 'Valloric/YouCompleteMe'          " 自动补全插件
Plugin 'tomasiser/vim-code-dark'         " vscode主题
Plugin 'dhruvasagar/vim-table-mode'      " markdown style format
Plugin 'iamcco/markdown-preview.nvim'    " markdown预览插件
Plugin 'iamcco/mathjax-support-for-mkdp' " markdown数学公式预览插件
Plugin 'junegunn/fzf'                    " 模糊搜索插件
Plugin 'junegunn/fzf.vim'
Plugin 'github/copilot.vim'              " github copilot插件
Plugin 'rhysd/vim-clang-format'          " clang格式化插件
Plugin 'vim-scripts/DrawIt'              " ascii画图插件

call vundle#end()         " required
filetype plugin indent on " required
" --------------------------------------------------------------
" ycm配置

" --------------------------------------------------------------
" fzf配置

" 设置历史记录位置
let g:fzf_history_dir = '~/.local/share/fzf-history'

" 绑定tag命令
let g:fzf_tags_command = 'ctags -R'

" 设置搜索窗口位置; up:上; down:下; left:左; right:右;
let g:fzf_layout = {'down':'~35%'}

" 设置颜色
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" 打开文件搜索窗口 ctrl + p
nmap <C-p> :Files <cr>
inoremap <C-p> <esc>:Files<cr>

" 打开内容(tag)搜索窗口 ctrl + t
nmap f :Tags <cr>
inoremap <C-f> <esc>:Tags<cr>
" --------------------------------------------------------------
" vim-go插件

let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:godef_split=2
" --------------------------------------------------------------
"  vim-rust 插件

syntax enable                     " 打开语法高亮
filetype plugin indent on         " 启动文件类型插件、缩进和语法高亮功能

let g:rustfmt_autosave = 1        " 保存时自动格式化
let g:rustfmt_command = "rustfmt" " 自定义格式化命令
" --------------------------------------------------------------
" NERDTree设置 F10

" 打开和关闭NERDTree快捷键
map <F10> :NERDTreeToggle<CR>

" 设置宽度
let NERDTreeWinSize=25

" 设置git
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" --------------------------------------------------------------
" tagbar插件 F9

nmap <F9> :TagbarToggle<CR>
let g:tagbar_ctags_bin=$CTAGS
let g:tagbar_width=50
"autocmd BufReadPost *.h,*.c,*.cc,*.hpp,*.cpp,*.go call tagbar#autoopen() " go和c++环境自动打开tagbar
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
	\ }
" --------------------------------------------------------------
" markdown预览插件 F8 打开/F4 关闭

" 在打开markdown文件时自动打开预览
let g:mkdp_auto_start=0

" 在编辑markdown文件时判断预览是否以打开，如果没有，自动打开
let g:mkdp_auto_open=1

" 在切换buffer的时候自动关闭预览
let g:mkdp_auto_close=1

" 网络中的其他计算机也能访问预览页面
let g:mkdp_open_to_the_world=1

" 固定IP和端口号,默认随机
let g:mkdp_open_ip='127.0.0.1'
let g:mkdp_open_port='443'

" 普通模式-打开/关闭预览
nmap <silent> <F8> <Plug>MarkdownPreview 
nmap <silent> <F4> <Plug>StopMarkdownPreview 

" 插入模式-打开/关闭预览
imap <silent> <F8> <Plug>MarkdownPreview 
imap <silent> <F4> <Plug>StopMarkdownPreview 
" --------------------------------------------------------------
" markdown格式化插件

let g:table_mode_corner = '|'
let g:table_mode_border=0
let g:table_mode_fillchar=' '

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
" --------------------------------------------------------------
"  github copilot插件


" --------------------------------------------------------------
" clang格式化插件

" 禁用默认 <Tab> 映射（避免和补全冲突）
let g:copilot_no_tab_map = v:true

" 延迟弹出提示
let g:copilot_idle_delay = 500

" 禁用自动弹出提示（推荐不禁用）
" let g:copilot_enabled = v:false

" 用 Tab 接受 Copilot 建议
imap <silent><expr> <Tab> copilot#Accept("\<Tab>")

" 切换copilot方案
imap <C-j> <Plug>(copilot-next)
imap <C-k> <Plug>(copilot-previous)

" 手动开启 / 关闭 Copilot
nnoremap <leader>ce :Copilot enable<CR>
nnoremap <leader>cd :Copilot disable<CR>

" 开启 / 关闭 panel窗口
nnoremap <leader>cp :Copilot panel<CR>
autocmd FileType copilot-panel nnoremap <buffer> q :q<CR>

" 固定panel窗口在右侧并设置宽度
autocmd BufWinEnter copilot://* wincmd L | vertical resize 80

" 禁止panel抢焦点
autocmd FileType copilot-panel setlocal nobuflisted

" 设置提示的颜色(深色主题：#555555 / #666666，浅色主题：#aaaaaa / #999999)
highlight CopilotSuggestion guifg=#999999 ctermfg=8

" 限定文件类型
let g:copilot_filetypes = {
      \ 'c': v:true,
      \ 'cpp': v:true,
      \ 'go': v:true,
      \ 'rust': v:true,
      \ 'python': v:true,
      \ }
" --------------------------------------------------------------
" DrawIt

" 使用方法:
"   \di  启动DrawIt模式
"   \ds  停止DrawIt模式
"   方向键绘制线条, 空格擦除, v进入可视模式框选区域
"   箭头: >, <, ^, v
"   拐角: +
"   交叉: +
" --------------------------------------------------------------