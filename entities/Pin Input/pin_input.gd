extends StaticBody2D

signal input_activated
signal input_deactivated

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var interaction_type : int

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interaction_type = 0
	
func on_interactable_activated() -> void:
	interaction_type = 1
	animation_player.play("player approach")
	input_activated.emit()
	
	
func on_interactable_deactivated() -> void:
	animation_player.play("player away")
	interaction_type = 0
	input_deactivated.emit()
	
	
