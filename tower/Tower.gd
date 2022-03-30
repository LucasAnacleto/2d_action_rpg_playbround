extends StaticBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4

onready var playerDetectionZone = $PlayerDetectionZone

var velocity = Vector2.ZERO

func _process(delta):
	seek_player(delta)
	
func seek_player(delta):
	if playerDetectionZone.can_see_player():
		var player = playerDetectionZone.player
		accelerate_towards_point(player.global_position, delta)
		
		
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
