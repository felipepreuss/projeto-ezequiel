class_name WeaponsManager extends Node3D
@export var auto: bool
@export var have_ammo = true
@export var current_ammo: int
@export var ammo :int
@export var max_ammo: int
@export var can_reload := false
@export var ray: RayCast3D
@export var local: Marker3D #muda o nome
@export var number_balas: int #muda muito o nome

var gun_equipped = false
var current_gun = get_child(1)
var gun_limit = 1
var gun_count = 0
@export var weapon_scenes : Array[PackedScene] = [ # muda pra export pq vai ficar mais leve
	preload("res://Scenes/shotgun.tscn"),
	preload("res://Scenes/Pistol.tscn"),
	preload("res://Scenes/metralhadora.tscn")
]

func _physics_process(delta: float) -> void: 
	handle_shooting()
	handle_weapon_switch()
	handle_reload()
	update_ammo_display()
func handle_shooting():
	if Input.is_action_just_pressed('Left-Click') and gun_equipped and current_gun:
		if current_gun.current_ammo >= current_gun.number_balas:
			current_gun.current_ammo -= number_balas
			if current_gun.current_ammo < 1:
				have_ammo = false
		else:
			print('Sem balas suficientes!')
	if auto and Input.is_action_pressed("Left-Click"):
		if current_gun.current_ammo >= current_gun.number_balas:
			current_gun.current_ammo -= number_balas
			if current_gun.current_ammo < 1:
				have_ammo = false
		else:
			print('Sem balas suficientes!')

func handle_weapon_switch():
	for i in range(weapon_scenes.size()):
		if Input.is_physical_key_pressed(KEY_0 + i + 1):
			switch_weapon(i)
			break

func handle_reload():
	if Input.is_action_just_pressed('Reload') and gun_equipped:
		if current_gun.current_ammo < current_gun.max_ammo and current_gun.ammo >= 0:
			var to_reload = min(current_gun.max_ammo - current_gun.current_ammo, current_gun.ammo)
			current_gun.current_ammo += to_reload
			current_gun.ammo -= to_reload
			have_ammo = current_gun.current_ammo > 0
			print('Recarregado , to_reload,  balas.')

func update_ammo_display():
	print(str(current_ammo, '/', ammo))

func instantiate_gun(index: int, local: Marker3D):
	if gun_count < gun_limit:
		gun_count += 1
		var gun = weapon_scenes[index].instantiate()
		gun.position = Vector3.ZERO  # Reset to avoid offset
		add_child(gun)
		gun.add_to_group('Gun')
		current_gun = gun
		sync_stats_from_gun()
		gun_equipped = true
		gun_count += 1

func switch_weapon(index: int):
	if current_gun:
		
		current_gun.queue_free()
		gun_equipped = false
		gun_count = 0
	instantiate_gun(index, local)

func sync_stats_from_gun():
	if current_gun and gun_equipped:
		current_ammo = current_gun.current_ammo
		ammo = current_gun.ammo
		max_ammo = current_gun.max_ammo
		number_balas = current_gun.number_balas
		have_ammo = current_ammo > 0

func shooting(mira: RayCast3D, dano: int):
	if mira.is_colliding():
		var target = mira.get_collider()
		if target.is_in_group('Enemy'):
			target.calcularDano(dano)
			print('Dano causado! Vida restante ', target.vida)
