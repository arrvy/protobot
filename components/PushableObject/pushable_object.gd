extends CharacterBody2D
class_name PushableObject

@export var push_distance := 10.0
@export var push_speed := 25.0

var pushing := false
var move_vector := Vector2.ZERO
var target_position := Vector2.ZERO

func _physics_process(delta):
	if pushing:
		var to_target = target_position - global_position
		var step = move_vector * push_speed * delta

		if step.length() >= to_target.length():
			global_position = target_position
			pushing = false
		else:
			move_and_collide(step)

func push_once(dir: Vector2):
	if pushing:
		return

	move_vector = dir.normalized()
	target_position = global_position + move_vector * push_distance
	pushing = true
