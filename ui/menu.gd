extends Control


func _on_mulai_pressed() -> void:
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_kredit_pressed() -> void:
	pass # Replace with function body.


func _on_keluar_pressed() -> void:
	get_tree().quit()
