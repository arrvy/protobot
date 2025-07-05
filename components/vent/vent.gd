extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_activated)
	interactable_component.interactable_deactivated.connect(on_deactivated)
	collision_layer = 1

func on_activated(actor: Node2D) -> void:
	collision_layer = 2

func on_deactivated(_actor: Node2D) -> void:
	collision_layer = 1
