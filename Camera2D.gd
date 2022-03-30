extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var bottomRigth = $Limits/BottomRigth

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRigth.position.y
	limit_right = bottomRigth.position.x
	
