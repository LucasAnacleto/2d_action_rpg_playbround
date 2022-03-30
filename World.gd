extends Node2D






func _ready():
	if OS.has_touchscreen_ui_hint():
		var control = get_node("Controlle")
		remove_child(control)

