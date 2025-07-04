extends "res://entities/base_robot.gd"

@onready var push_area = $PushDirection
@onready var main_game: Node2D = $".."
@onready var iron_door_top: StaticBody2D = $"../Interactable Holder/IronDoor Top"




func _physics_process(delta):
	super._physics_process(delta)
	var dir = get_input_vector()
	update_push_detector(dir)
	push_object(dir)
	interactable_detector()

func update_push_detector(dir):
	if dir != Vector2.ZERO:
		push_area.position = dir.normalized() * 10
		
func push_object(dir: Vector2):
	for body in push_area.get_overlapping_bodies():
		if body is PushableObject:
			body.push_once(dir)
			
func interactable_detector():
	match main_game.interaction:
		0:
			pass
		1:
			interaction_handle(iron_door_top)
			
func interaction_handle(interaction):
	if Input.is_action_just_pressed("interact"):
		interaction.on_interactable_activated()
			
