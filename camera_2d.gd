extends Camera2D


var zoom_target := Vector2(1, 1)
var zoom_speed := 5.0

func _process(delta):
	zoom = zoom.lerp(zoom_target, zoom_speed * delta)

func set_zoom_target(z: Vector2):
	zoom_target = z
	
