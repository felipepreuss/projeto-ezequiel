extends Label
@export var manager : WeaponsManager
var nome 
func _physics_process(delta: float) -> void:
	if manager.gun_equipped:
		text = str(manager.current_ammo)+"/"+str(manager.ammo)
