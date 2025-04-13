class_name WeaponsManager extends Node3D
@export var auto: bool
@export var have_ammo := true
@export var current_ammo: int
@export var ammo: int
@export var max_ammo: int
@export var can_reload := false
@export var ray: RayCast3D
@export var spawn_point: Marker3D #muda o nome
@export var balas: int #muda muito o nome

var gun_equipped := false
var current_gun
var gun_limit := 1
var gun_count := 0
@export var weapon_scene: PackedScene = preload("res://Scenes/shotgun.tscn")

func _physics_process(delta: float) -> void:
	if gun_equipped:
		sync_stats_from_gun()
	handle_shooting()
	handle_weapon_switch()
	handle_reload()
	update_ammo_display()

func handle_shooting():
	if Input.is_action_just_pressed("Left-Click") and gun_equipped and current_gun:
		if current_ammo >= balas:
			current_ammo -= balas
			if current_ammo < 1:
				have_ammo = false
		else:
			print("Sem balas suficientes!")

func handle_weapon_switch():
	if Input.is_physical_key_pressed(KEY_1): # só um slot agora
		switch_weapon()

func handle_reload():
	if Input.is_action_just_pressed("Reload") and gun_equipped:
		if current_ammo < max_ammo and ammo > 0:
			var to_reload = min(max_ammo - current_ammo, ammo)
			current_ammo += to_reload
			ammo -= to_reload
			have_ammo = current_ammo > 0
			print("Recarregado: ", to_reload, " balas.")

func update_ammo_display():
	print(str(current_ammo, '/', ammo))

func instantiate_gun(local: Marker3D):
	if gun_count < gun_limit and weapon_scene:
		var gun = weapon_scene.instantiate()
		local.position = gun.position  # Reset to avoid offset
		add_child(gun)
		gun.add_to_group("Gun")
		current_gun = gun
		gun_equipped = true
		gun_count += 1

func switch_weapon():
	if current_gun:
		current_gun.queue_free()
		gun_equipped = false
		gun_count = 0
	instantiate_gun(spawn_point)

func sync_stats_from_gun():
	if current_gun and gun_equipped:
		current_ammo = current_gun.current_ammo
		ammo = current_gun.ammo
		max_ammo = current_gun.max_ammo
		balas = current_gun.balas
		have_ammo = current_ammo > 0

func shooting(mira: RayCast3D, dano: int):
	if mira.is_colliding():
		var target = mira.get_collider()
		if target.is_in_group("Enemy") and target.has_method("calcularDano"):
			target.calcularDano(dano)
			print("Dano causado! Vida restante: ", target.vida)
