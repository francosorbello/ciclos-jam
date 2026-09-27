extends Node
## system similar to the global event system, but using godot signals instead
## Usage:
## 1. Add your signal here. Then, 
##  you can call GlobalSignal.signal_name.connect() to connect to it
##  you can call GlobalSignal.signal_name.emit() to emit it

signal change_scene_requested(scene_name:String)
signal restart_level_requested