extends WeaponsManager

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Left-Click") and auto:
		shooting(ray,8)
