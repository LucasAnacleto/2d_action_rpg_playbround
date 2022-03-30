extends KinematicBody2D

const PlayerHurtSound = preload("res://Music and Sounds/AudioStreamPlayer.tscn")
const Tower = preload("res://tower/Tower.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var inpunt_vector = Vector2.ZERO
onready var stats = PlayerStats
var joyAction = false


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var joy = $Controlle/Analog/Node2D/Big/Stick



func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector


func _physics_process(delta):
	match state:
		MOVE:
			if Input.is_action_pressed("touch"):
				joyAction = true
				move_state(delta)
			else:
				joyAction = false
				move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)


func move_state(delta):
	
	if not joyAction:
		inpunt_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		inpunt_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		inpunt_vector = inpunt_vector.normalized()
	else:
		inpunt_vector = joy.get_value()
	
	if inpunt_vector != Vector2.ZERO:
		roll_vector = inpunt_vector
		swordHitbox.knockback_vector = inpunt_vector
		animationTree.set("parameters/Idle/blend_position", inpunt_vector)
		animationTree.set("parameters/Run/blend_position", inpunt_vector)
		animationTree.set("parameters/Attack/blend_position", inpunt_vector)
		animationTree.set("parameters/Roll/blend_position", inpunt_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(inpunt_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("tower"):
		var tower = Tower.instance()
		get_parent().add_child(tower)
		tower.global_position = position
		
		
func roll_state(_delta):
	velocity  = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
func attack_state(_delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)
	
func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE

	
func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSounds = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSounds)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Star")


func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")

