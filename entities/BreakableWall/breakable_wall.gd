extends StaticBody2D

func _ready():
	add_to_group("breakable_walls")  

func destroy():
	print("Hancur:", name)
	queue_free()
