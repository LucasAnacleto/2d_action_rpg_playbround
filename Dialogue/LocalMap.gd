
extends Node
class_name LocalMap

signal enemies_encountered(formation)
# warning-ignore:unused_signal
signal dialogue_finished

onready var dialogue_box = $MapInterface/DialogueBox


func _ready() -> void:
	assert(dialogue_box)
	for action in get_tree().get_nodes_in_group("map_action"):
		(action as MapAction).initialize(self)


#func spawn_party(party) -> void:
#	grid.pawns.spawn_party(grid, party)


func start_encounter(formation) -> void:
	emit_signal("enemies_encountered", formation.instance())


func play_dialogue(data):
	dialogue_box.start(data)
	yield(dialogue_box, "dialogue_ended")
