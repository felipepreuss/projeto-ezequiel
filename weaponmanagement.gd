class_name WeaponsManager extends Node3D 
@export var have_ammo = true
@export var current_ammo = 30
@export var ammo = 30
@export var max_ammo = 360
@export var can_reload = false
@export var packed:Array[PackedScene] = [preload("res://Scenes/Pistol.tscn"),
preload("res://Scenes/DoublePistol.tscn")]
@export var ray:RayCast3D
@export var local:Marker3D
var limit = 1
var number = 0
var gun_equipped = false
@export var number_balas = 1
func instantiate_gun(type:int,local:Marker3D):
	if number < limit:
		gun_equipped = true
		number += 1
		var gun = packed[type].instantiate()
		local.position = gun.position
		local.add_child(gun)
func _physics_process(delta: float) -> void:
	reload()
	if Input.is_action_just_pressed("Switch"):
		var int_switch:int = 0
		instantiate_gun(int_switch,local)
	if Input.is_action_just_pressed('Left-Click') and have_ammo and gun_equipped:
		current_ammo -= number_balas
		shooting(ray)
	print(current_ammo)
func reload():
	if current_ammo <= 0:
		have_ammo = false
	if ammo > 0 or ammo != current_ammo:
		can_reload = true
	if ammo <= 0:
		can_reload = false
	if Input.is_action_just_pressed("Reload") and can_reload and gun_equipped:
		#Melhorar a lógica do tiro
		if current_ammo >= 1:
			have_ammo = true

func shooting(mira:RayCast3D):
	if mira.is_colliding():
		var target = mira.get_collider()
		if target.is_in_group('Enemy'):
			target.calcularDano(10)
			
	
