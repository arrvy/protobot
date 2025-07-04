extends CharacterBody2D
var robot = get_node_and_resource("res://entities/C-129/c_129.gd")
@export var move_speed: float = 100.0
@export var starting_direction: Vector2 = Vector2.DOWN

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var pushable_body_scene: PackedScene
var is_alive: bool = true

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	if not is_alive:
		return
	
	handle_death_input()
	
	var input_vector = get_input_vector()
	update_animation_parameters(input_vector)
	velocity = input_vector * move_speed
	move_and_slide()
	pick_new_state()
	

func get_input_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func update_animation_parameters(dir: Vector2):
	if dir != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", dir)
		animation_tree.set("parameters/Idle/blend_position", dir)

func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
func handle_death_input():
	if Input.is_action_just_pressed("die"):
		suicide()
		
func suicide():
	is_alive = false
	if pushable_body_scene:
		var body = pushable_body_scene.instantiate()
		body.global_position = global_position
		get_parent().add_child(body)
	queue_free()
	
	

	
