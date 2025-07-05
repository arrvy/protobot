extends StaticBody2D

const PRESSURE_PLATE_45634 = preload("res://entities/Preassure Plate/pressure-plate-45634.mp3")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var interactable_component: InteractablePressurePlate = $InteractablePressureTime
var sum_pressed: int

signal gate_activated
signal gate_deactivated

func _ready() -> void:
	interactable_component.interactable_activated.connect(preassure_activated)
	interactable_component.interactable_deactivated.connect(preassure_deactivated)
	sum_pressed = 0
	animated_sprite_2d.pause()

func preassure_activated():
	
	audio_stream_player_2d.pitch_scale = randf() + 0.5
	audio_stream_player_2d.play()
	sum_pressed +=1
	print(sum_pressed)
	if sum_pressed == 3:
		animated_sprite_2d.play("pressed")
		gate_activated.emit()
	

func preassure_deactivated():
	
	
	audio_stream_player_2d.pitch_scale = randf()
	audio_stream_player_2d.play()
	sum_pressed-=1
	print(sum_pressed)
	if sum_pressed==2:
		animated_sprite_2d.play("unpressed")

		
		
		
