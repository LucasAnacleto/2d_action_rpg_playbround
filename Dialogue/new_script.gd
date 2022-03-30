extends Node

class_name MapAction

signal finished
var local_map
var active: bool = true


func _ready() -> void:
	add_to_group("map_action")


func initialize(_local_map):
	local_map = _local_map


func interact() -> void:
	print("You forgot to override the interact method in " + name)
	emit_signal("finished")
