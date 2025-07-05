extends Node2D

signal gate_activated

@onready var preassure_plate: StaticBody2D = $"Preassure Plate"
@onready var preassure_plate_2: StaticBody2D = $"Preassure Plate2"
@onready var preassure_plate_3: StaticBody2D = $"Preassure Plate3"
@onready var preassure_plate_4: StaticBody2D = $"Preassure Plate4"

var sum_pressed:int
func _ready() -> void:
	preassure_plate.plate_activated.connect(count_pressed1)
	preassure_plate_2.plate_activated.connect(count_pressed2)
	preassure_plate_3.plate_activated.connect(count_pressed3)
	preassure_plate_4.plate_activated.connect(count_pressed4)
	
	preassure_plate.plate_deactivated.connect(count_pressed1)
	preassure_plate_2.plate_deactivated.connect(count_pressed2)
	preassure_plate_3.plate_deactivated.connect(count_pressed3)
	preassure_plate_4.plate_deactivated.connect(count_pressed4)

func _process(delta: float) -> void:
	
	# print(sum_pressed)
	
	if sum_pressed == 4:
		print("kebuka")
		gate_activated.emit()
		sum_pressed = 0
		preassure_plate.interactable_component.collision_mask = 1
		preassure_plate_2.interactable_component.collision_mask = 1
		preassure_plate_3.interactable_component.collision_mask = 1
		preassure_plate_4.interactable_component.collision_mask = 1
		
func count_pressed1():
	sum_pressed+=int(preassure_plate.pressed)
func count_pressed2():
	sum_pressed+=int(preassure_plate_2.pressed)
func count_pressed3():
	sum_pressed+=int(preassure_plate_3.pressed)
func count_pressed4():
	sum_pressed+=int(preassure_plate_4.pressed)
		
