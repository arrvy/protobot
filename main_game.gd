extends Node2D

@export var c129_scene: PackedScene
@export var bomb_scene: PackedScene
@export var curut_scene: PackedScene
@export var bakuaer_scene: PackedScene

@onready var spawn_point = $SpawnPoint
@onready var tilemap = $MainMap
@onready var pin_input: StaticBody2D = $"Interactable Holder/Pin Input"
@onready var vent_top: StaticBody2D = $"Interactable Holder/Vent Top"
@onready var ending_triggered: Area2D = $"ENDING TRIGGERED"
@onready var ending_player: AnimationPlayer = $"Ending Player"
@onready var endingtriggered: EndingTriggered = $ENDINGTRIGGERED

var player: Node2D
var interaction : int
var robot_index := 0

func _ready() -> void:
	spawn_robot()
	endingtriggered.interactable_activated.connect(win)
	pin_input.input_deactivated.connect(on_input_activated)
	pin_input.input_activated.connect(on_input_activated)
	vent_top.input_activated.connect(on_vent_activated)
	vent_top.input_deactivated.connect(on_vent_activated)
	
func _process(delta):
	var mat := tilemap.material as ShaderMaterial
	if mat:
		# Kirim posisi layar (viewport) ke shader
		var player_screen_pos = get_viewport().get_camera_2d().unproject_position(player.global_position)
		mat.set_shader_parameter("player_pos", player_screen_pos)
		
func on_input_activated():
	interaction = pin_input.interaction_type
	print(interaction)
	
func on_vent_activated():
	interaction = vent_top.interaction_type
	print(interaction)

# Spawn robot berdasarkan index
func spawn_robot():
	if player:
		player.queue_free()

	var scene: PackedScene
	match robot_index:
		0: scene = c129_scene
		1: scene = bomb_scene
		2: scene = curut_scene
		3: scene = bakuaer_scene
		_: 
			print("Semua robot habis.")
			return

	player = scene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)

	# Hubungkan sinyal kematian robot
	if player.has_signal("robot_died"):
		player.connect("robot_died", _on_robot_died)

	robot_index += 1
	
# Jika robot mati, ganti robot selanjutnya
func _on_robot_died(robot: Node):
	spawn_point.global_position = robot.global_position
	spawn_robot()
	
func win():
	ending_player.play("ENDINGGG")
