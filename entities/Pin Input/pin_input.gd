extends StaticBody2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
	
func on_interactable_activated() -> void:
	animation_player.play("player approach")
	
	
func on_interactable_deactivated() -> void:
	animation_player.play("player away")
	
	
