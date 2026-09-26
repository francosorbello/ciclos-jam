extends Control

func add_level(level: Node):
	$SubViewportContainer/SubViewport.add_child(level)