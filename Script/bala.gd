extends CharacterBody3D

var speed = 80

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,-speed) * delta

func _on_bullet_lifetime_timeout() -> void:
	queue_free()
