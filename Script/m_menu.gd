extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn") # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
