extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interactable_component: InteractableComponent = $InteractableComponent
var interaction_type := 0
signal input_activated
signal input_deactivated
func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_emitter)
	interactable_component.interactable_deactivated.connect(on_interactable_deemitter)

func on_interactable_emitter():
	interaction_type = 2
	input_activated.emit()
	animation_player.play("player approach")
	
func on_interactable_deemitter():
	interaction_type = 0
	input_deactivated.emit()
	animation_player.play("player away")
	
func on_interactable_activated():
	collision_layer = 2
	animated_sprite_2d.play("Wreck")
func on_interactable_deactivated():
	pass
