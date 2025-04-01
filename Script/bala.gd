extends Area3D

var speed = 80

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,-speed) * delta


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		body.queue_free()
