extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var c_129: CharacterBody2D = $"../../C-129"

func _ready() -> void:
	
	collision_layer = 1
	
func on_interactable_activated() -> void:
	animated_sprite_2d.play("open")
	collision_layer = 2
	
func on_interactable_deactivated() -> void:
	animated_sprite_2d.play("close")
	collision_layer = 1
	
