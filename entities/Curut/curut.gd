extends "res://entities/base_robot.gd"

func _ready():
	super()
	
	var cam = get_tree().root.get_node("MainGame/Camera2D") 
	cam.set_zoom_target(Vector2(7, 7))  
	
