extends Node2D


@onready var player = $"C-129"
@onready var tilemap = $MainMap

func _process(delta):
	var mat := tilemap.material as ShaderMaterial
	if mat:
		# Kirim posisi layar (viewport) ke shader
		var player_screen_pos = get_viewport().get_camera_2d().unproject_position(player.global_position)
		mat.set_shader_parameter("player_pos", player_screen_pos)
