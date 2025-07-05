extends StaticBody2D

const PRESSURE_PLATE_45634 = preload("res://entities/Preassure Plate/pressure-plate-45634.mp3")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var delay_timer: Timer = $Timer
@onready var interactable_component: InteractablePressurePlate = $InteractablePressureTime
var is_pressed: bool

func _ready() -> void:
	is_pressed = false
	print(is_pressed)

	interactable_component.interactable_activated.connect(preassure_activated)
	interactable_component.interactable_deactivated.connect(preassure_deactivated)
	delay_timer.timeout.connect(_on_delay_timeout)
	delay_timer.one_shot = true
	delay_timer.wait_time = 1.5 # ubah sesuai kebutuhan (delay sebelum unpressed)

func preassure_activated():
	print(is_pressed)
	if is_pressed:
		print("udah ke pressed")
		return # Sudah dalam keadaan aktif
	is_pressed = true
	print("pressed")
	delay_timer.stop() # Batalkan countdown kalau diinjak lagi
	animated_sprite_2d.play("pressed")
	audio_stream_player_2d.pitch_scale = randf() + 0.5
	audio_stream_player_2d.play()

func preassure_deactivated():
	
	delay_timer.start() # Mulai countdown untuk lepas

func _on_delay_timeout():
	#if not is_pressed: # pastikan tidak ada yang injak lagi
		is_pressed = false
		animated_sprite_2d.play("unpressed")
		audio_stream_player_2d.pitch_scale = randf()
		audio_stream_player_2d.play()
