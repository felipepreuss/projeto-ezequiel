extends CharacterBody3D
@onready var player = $"../P_"
const SPEED = 1.25
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	look_at(player.global_position, Vector3(0,1,0))
	rotation.x = 0
	rotation.z = 0
	var direction= (player.global_position - global_transform.origin).normalized()
	#position.y = 0
	
	velocity = direction * SPEED
	
	#rotation.z = lerp_angle(rotation.z,deg_to_rad(90),10 * delta)
	move_and_slide()

 
