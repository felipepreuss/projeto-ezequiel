extends WeaponsManager
@export var raycontainer : Node3D
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Left-Click"):
		for r in raycontainer.get_children():
			r.target_position.x = randi_range(10,-10)
			r.target_position.y = randi_range(10,-10)
