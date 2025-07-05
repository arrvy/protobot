extends "res://entities/base_robot.gd"

@onready var push_area = $PushDirection
@onready var main_game: Node2D = $".."
@onready var iron_door_top: StaticBody2D = $"../Interactable Holder/IronDoor Top"

@onready var pin_input: StaticBody2D = $"../Interactable Holder/Pin Input"

func _ready():
	super()
	
	#var cam = get_tree().root.get_node("MainGame/Camera2D") 
	#cam.set_zoom_target(Vector2(2, 2))  
	
func _physics_process(delta):
	super._physics_process(delta)
	var dir = get_input_vector()
	update_push_detector(dir)
	push_object(dir)


func update_push_detector(dir):
	if dir != Vector2.ZERO:
		push_area.position = dir.normalized() * 10
		
func push_object(dir: Vector2):
	for body in push_area.get_overlapping_bodies():
		if body is PushableObject:
			body.push_once(dir)
			
