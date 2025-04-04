extends Label
@export var manager : WeaponsManager 
func _physics_process(delta: float) -> void:
	text = str(manager.current_ammo)+"/"+str(manager.ammo)
