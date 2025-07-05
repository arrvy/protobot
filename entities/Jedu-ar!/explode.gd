extends Node2D

@export var explosion_radius: float = 64.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var explosion: GPUParticles2D = $explosion

func _ready() -> void:
	explosion.emitting = true
	audio_stream_player_2d.play()
	anim.play("explode")
	anim.animation_finished.connect(on_explosion_finished)

	detect_and_destroy_walls()

func detect_and_destroy_walls() -> void:
	for wall in get_tree().get_nodes_in_group("breakable_walls"):
		if wall.global_position.distance_to(global_position) <= explosion_radius:
			if wall.has_method("destroy"):
				print("Hancurkan:", wall.name)
				wall.destroy()

func on_explosion_finished() -> void:
	queue_free()
