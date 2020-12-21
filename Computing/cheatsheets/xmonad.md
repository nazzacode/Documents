# Xmonad Cheatsheet

## Todo's
[ ] put commands in ``

## Mod key
The default modifier key is 'alt'

mod = Win

## Launching and killing programs
mod-Shift-Enter  Launch terminal
mod-p            Launch dmenu
mod-Shift-p      Launch gmrun
mod-Shift-c      Close/kill the focused window
mod-Shift-x      kill all windows in workspace
mod-Space        Rotate through the available layout algorithms
mod-Shift-Space  Reset the layouts on the current workSpace to default
mod-n            Resize/refresh viewed windows to the correct size

## Move focus up or down the window stack
mod-Tab        Move focus to the next window
mod-Shift-Tab  Move focus to the previous window
mod-j          Move focus to the next window
mod-k          Move focus to the previous window
mod-m          Move focus to the master window

## Modifying the window order
mod-Return   Swap the focused window and the master window
mod-Shift-j  Swap the focused window with the next window
mod-Shift-k  Swap the focused window with the previous window

## resizing the master/slave ratio
mod-h  Shrink the master area
mod-l  Expand the master area

## Floating layer support
mod-t  Push window back into tiling; unfloat and re-tile it

## Increase or decrease number of windows in the master area
mod-comma  (mod-,)   Increment the number of windows in the master area
mod-period (mod-.)   Deincrement the number of windows in the master area

## Quit, or restart
mod-Shift-q  Quit xmonad
mod-q        Restart xmonad
mod-[1..9]   Switch to workSpace N

## Workspaces & screens
mod-Shift-[1..9]   Move client to workspace N
mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3
mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3

## Mouse bindings: default actions bound to mouse events
mod-button1  Set the window to floating mode and move by dragging
mod-button2  Raise the window to the top of the stack
mod-button3  Set the window to floating mode and resize by dragging
