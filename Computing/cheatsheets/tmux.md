# Tmux Cheatsheet

## Todo
- lineup columns

## Shortcuts
mod key = `C-a` (Control-a, switched from C-b default)

## General
`mod ?` : List commands
`C-d`   : Close split (or window)
`mod d` : detach current session (send to backgroud)
`mod w` : List all; sessions, windows, tabs, panes
`mod $` : rename session
`mod [` : copy mode (with vim bindings), supports search "/",

## Windows/Tabs
`mod c`        : create new window/tab
`mod ,`        : rename window
`mod n`        : switch next window/tab
`mod p`        : switch previous window/tab
`mod <number>` : switch window/tab

## Splits 
`mod %`             : Horizontal split
`mod "`             : Vertical split
`mod <arrow key>`   : move between split
`mod C-<arrow key>` : resize split
`mod z`             : maximize split in window (toggle)
`mod }`             : swap pane with next
`mod {`             : swap pane with previous

## Command Tools
`tmux ls`                             : list running sessions
`tmux attach -t <number | name>`      : attach to session
`tmux new -s <session name>`          : created new named session
`tmux rename-session -t 0 <new name>` : rename session
