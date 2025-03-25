<<<<<<< HEAD
extends Area3D
=======
extends CharacterBody3D
>>>>>>> 2a6804b3367ede3fb9d8c0f89734f36c78e09ad4

var speed = 80

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0,0,-speed) * delta

func _on_bullet_lifetime_timeout() -> void:
	queue_free()
<<<<<<< HEAD

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('Inimigos'):
		body.vida -= 30
		if body.vida <= 0:
			body.queue_free()
=======
>>>>>>> 2a6804b3367ede3fb9d8c0f89734f36c78e09ad4
