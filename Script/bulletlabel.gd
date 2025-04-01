extends Label

func _physics_process(delta: float) -> void:
	text = str(Globals.current_ammo)+"/"+str(Globals.ammo)
