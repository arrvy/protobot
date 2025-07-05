extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var big_pressure_plate: StaticBody2D = $"../BigPressurePlate"

func _ready() -> void:
	big_pressure_plate.gate_activated.connect(on_interactable_activated)
	collision_layer = 1
	
func on_interactable_activated() -> void:
	animated_sprite_2d.play("open_door")
	collision_layer = 2
	
func on_interactable_deactivated() -> void:
	animated_sprite_2d.play("close_door")
	collision_layer = 1
	
