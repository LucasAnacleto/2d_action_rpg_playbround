extends StaticBody2D

signal interaction_finished

onready var anim = $AnimationPlayer
onready var wobble = $wobble
onready var hurt = $Hurtbox

var going_left=true
var extreme_left=-100
var extreme_right=100
var speed=1

export var vanish_on_interaction := false

func _ready():
	wobble.region_enabled = true

func _unhandled_input(event):
	if event.is_action_pressed("click") and not wobble.region_enabled:
		start_interaction()
		get_tree().set_input_as_handled()

func start_interaction() -> void:
	get_tree().paused = true
	var actions = $Actions.get_children()
	assert(actions != [])
	for action in actions:
		action.interact()
	emit_signal("interaction_finished", self)
	if vanish_on_interaction:
		queue_free()
	get_tree().paused = false


func _on_Hurtbox_body_exited(_body):
	wobble.region_enabled = true
	anim.stop()


func _on_Hurtbox_body_entered(_body):
	wobble.region_enabled = false
	anim.play("wobble")
