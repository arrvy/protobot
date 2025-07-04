extends Node2D


@onready var player = $"C-129"
@onready var tilemap = $MainMap
@onready var pin_input: StaticBody2D = $"Interactable Holder/Pin Input"
var interaction : int

func _ready() -> void:
	pin_input.input_deactivated.connect(on_input_activated)
	pin_input.input_activated.connect(on_input_activated)
	
func _process(delta):
	var mat := tilemap.material as ShaderMaterial
	if mat:
		# Kirim posisi layar (viewport) ke shader
		var player_screen_pos = get_viewport().get_camera_2d().unproject_position(player.global_position)
		mat.set_shader_parameter("player_pos", player_screen_pos)
		
func on_input_activated():
	interaction = pin_input.interaction_type
	print(interaction)
