For there is no perfect coder, he is dust in the kingdom of our land

Vim Cheatsheet
==============

* TODO: line up dashes 
* TODO: coc shortcuts   
* TODO: subheadings

"Vim is an artform, there is a more efficient and beautiful way to do many things."

Basic Movement
--------------
h,j,k,l        - movement\
10j            - move 10 lines down\
w,e,b          - (next) word, end (of word), back (word)\
5w             - move 5 words\
30i "dash" esc - 30 lovely dashest\
f,F            - next/previous occurrence of character\
%              - go to matching parenthesis\
0,$            - start and end of line\
*,#            - next and previous occurence of word under cursor\
gg,G           - beggining/end of file\
NG             - take you to line number N\
Ctrl-E/Y       - scroll up/down

Searching
---------
/   - searchtext\
n,N - next previous occurences

Insert & Delete
---------------
o,O - insert new line below/above\
x,X - deletes character under and to the left of cursor respectively\
r - replace letter under cursor\
d - deletes
dw - deletes first word to the right (and copies) 
p - paste

. - repeat previous command

v - visual mode (you select text with movement keys before deciding what to do with it 

gt, gT, ngt - change tab; fwd, backward, by number 

z



My Shortcuts
------------
inoremap jk <Esc> - Escape to normal mode

### Resize splits with arrowkeys ###
<Up>    :resize +1
<Down>  :resize -1
<Left>  :vertical resize +1
<Right> :vertical resize -1


## Ctrl Key Shortcuts ##
<C-n> :NERDTreeToggle<CR>

<C-t> :TagbarToggle<CR> 


## Leader Key Shortcuts ## 
[n]<leader>cc - comments out a line(s)
<leader>c$ - comments from cursor to end eol
<leader>cA - add comment at eol
[n]<leader>cl - switches to alternate delimiters
[n]<leader>cu - uncomments selected line
[n]<leader>c<space> - toggle comment

<leader>t :call OpenTerminal()

<leader>v :PandocPreview

