extends Area2D


var speed := 180
var direction := Vector2()

func _physics_process(delta):
	if direction.x > 0:
		rotation_degrees = 90
	elif direction.x < 0:
		rotation_degrees = -90
		
	if direction.y > 0:
		rotation_degrees = 180
	elif direction.y < 0:
		rotation_degrees = 0
		
	global_position += direction * speed * delta
