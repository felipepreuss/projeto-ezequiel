extends CanvasLayer

func _ready():
	visible = false
func _process(_delta):
	
	if Input.is_action_just_pressed("Pause") && !visible:
		visible = true
		get_tree().paused = true
		
	elif Input.is_action_just_pressed("Pause")	&& visible:
		visible = false
		get_tree().paused = false
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _on_resume_pressed():
	get_tree().paused = false
	visible = false
	 # Replace with function body.

func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/menu.tscn") # Replace with function body.
	
