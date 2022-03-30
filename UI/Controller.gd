extends Node


export var analog = true
export var navigation = true
export var buttons = true
export var pos = Vector2.ZERO
export var posSetting = Vector2.ZERO

onready var controllerAnalog = $Analog/Node2D
onready var controllerNavigation = $Navigation/Node2D
onready var controllerButtons = $Buttons/Node2D

export(Resource) var settingHeight = ProjectSettings.get_setting("display/window/size/height")
export(Resource) var settingWidth = ProjectSettings.get_setting("display/window/size/width")


func _ready():
	if analog:
		controllerAnalog.hide()
		
		posSetting = Vector2(settingHeight, settingWidth)
		
		posSetting.x = posSetting.x / 3
		posSetting.y = settingHeight - 60
		controllerNavigation.position = posSetting
	
	if navigation:
		controllerNavigation.hide()
		
		posSetting = Vector2(settingHeight, settingWidth)
		
		posSetting.x = posSetting.x / 3
		posSetting.y = settingHeight - 40
		controllerAnalog.position = posSetting
		
	if buttons:
		controllerButtons.hide()
	
	
