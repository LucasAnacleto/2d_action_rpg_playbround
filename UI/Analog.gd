extends Node

signal move_player(delta, stick_vector)

var stick_speed = 0
var stick_angle = 0
var stick_vector = Vector2.ZERO

onready var touch = $Analog/Big/Sprite/TouchScreenButton


func _process(delta):
	if touch.is_pressed():
		var man = stick_vector * stick_speed * delta
		emit_signal("move_player", delta, man)
