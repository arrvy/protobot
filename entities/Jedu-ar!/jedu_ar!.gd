extends "res://entities/C-129/c_129.gd"

@onready var explosion_timer: Timer = $ExplosionTimer

func _ready() -> void:
	super()
	
	explosion_timer.start() 
	explosion_timer.timeout.connect(on_explosion_timeout)

func on_explosion_timeout():
	var explosion_scene = preload("res://entities/Jedu-ar!/explode.tscn")
	var explosion_instance = explosion_scene.instantiate()
	explosion_instance.global_position = global_position
	get_tree().current_scene.add_child(explosion_instance)

	emit_signal("robot_died", self)
	queue_free()
	
func handle_death_input():
	pass
	
func suicide():
	explosion_timer.stop()
	on_explosion_timeout()
