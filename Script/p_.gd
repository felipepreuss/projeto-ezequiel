extends CharacterBody3D
@onready var crosshair = $UI/Crosshair
@onready var Head = $head
@onready var Camera = $head/Camera3D
@onready var vida = $head/HUD/Color/Vbox/Vida
@onready var weapon = $head/Camera3D/weapon
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Weapon related vars
var bala = preload("res://Scenes/bala.tscn")
@onready var pos = $head/Camera3D/bullet_pos
@onready var animation_player = $head/Camera3D/weapon/AnimationPlayer
const SENSITIVITY = 0.003

var life_value = 200

var strafe_rotation = 1

func _ready():
	vida.value = life_value
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crosshair.position.x = get_viewport().size.x /2 - 36 # Replace with function body.
	crosshair.position.y = get_viewport().size.y /2 - 36
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		Head.rotate_y(-event.relative.x * SENSITIVITY)
		Camera.rotate_x(-event.relative.y * SENSITIVITY)
		Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		Camera.rotate_z(deg_to_rad(strafe_rotation))
	if not Input.is_action_pressed("Left"):
		if Camera.rotation.z > 0:
			Camera.rotate_z(-deg_to_rad(strafe_rotation * 0.5))
	if Input.is_action_pressed("Right"):
		Camera.rotate_z(-deg_to_rad(strafe_rotation))
	if not Input.is_action_pressed("Right"):
		if Camera.rotation.z < 0:
			Camera.rotate_z(deg_to_rad(strafe_rotation*0.5))
	Camera.rotation.z = clamp(Camera.rotation.z , -0.05, 0.05)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backwards")
	var direction = (Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	
	#atirar
	if Input.is_action_just_pressed("Left-Click") and Globals.have_ammo:
		animation_player.play("shoot")
		var bullet = bala.instantiate()
		bullet.position = pos.global_position
		bullet.transform.basis = pos.global_transform.basis
		get_parent().add_child(bullet)
		Globals.current_ammo -= 1
	if Globals.current_ammo <= 0:
		Globals.have_ammo = false
	if Input.is_action_just_pressed("Reload") and !Globals.have_ammo:
		Globals.current_ammo += 30
		Globals.ammo -= Globals.current_ammo
		if Globals.current_ammo >= 1:
			Globals.have_ammo = true
