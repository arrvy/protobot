extends CharacterBody2D

@export var move_speed : float = 100

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine =  animation_tree.get("parameters/playback")


func _physics_process(delta: float) -> void:
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	print(direction)
	velocity = direction * move_speed
	
	move_and_slide()
	pick_state()
	update_animation_parameters(direction)
	
	
func update_animation_parameters (direction : Vector2):
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position",direction)
		animation_tree.set("parameters/walk/blend_position",direction)
		
func pick_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
	
