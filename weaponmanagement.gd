class_name WeaponsManager extends Node3D 
@export var have_ammo = true
@export var current_ammo = 30
@export var ammo = 30
@export var max_ammo = 360
@export var can_reload = false
@export var packed:Array[PackedScene] = [preload("res://Scenes/shotgun.tscn"),
preload("res://Scenes/Pistol.tscn"), preload('res://Scenes/metralhadora.tscn')]
@export var ray:RayCast3D
@export var local:Marker3D
var limit = 1
var number = 0
var gun_equipped = false
@export var number_balas = 1
var current_weapon = null
func _physics_process(delta: float) -> void:
	reload()
	for i in range(1, packed.size() + 1):
		if Input.is_physical_key_pressed(KEY_0 + i):
			switch_weapon(i - 1)
			break

	if Input.is_action_just_pressed("Left-Click") and have_ammo and gun_equipped:
		if current_ammo >= number_balas:
			current_ammo -= number_balas
			shooting(ray)
		else:
			current_ammo = 0
			have_ammo = false


func instantiate_gun(type: int, local: Marker3D):
	if number < limit:
		gun_equipped = true
		number += 1
		var gun = packed[type].instantiate()
		local.position = gun.position
		local.add_child(gun)
		current_weapon = gun

func switch_weapon(index: int):

	if current_weapon:
		current_weapon.queue_free()
		number = 0
		gun_equipped = false

	instantiate_gun(index, local)

func reload():
	if current_ammo <= 0:
		have_ammo = false
	if ammo > 0 or ammo != current_ammo:
		can_reload = true
	if ammo <= 0:
		can_reload = false
	if Input.is_action_just_pressed("Reload") and can_reload and gun_equipped:
		var to_reload = min(30 - current_ammo, ammo)
		current_ammo += to_reload
		ammo -= to_reload
		have_ammo = current_ammo > 0

func shooting(mira: RayCast3D):
	if mira.is_colliding():
		var target = mira.get_collider()
		if target.is_in_group("Enemy"):
			target.calcularDano(20)
			print(target.vida)
