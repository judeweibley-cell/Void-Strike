class_name Player extends CharacterBody2D

signal shoot_bullet
signal send_location
signal score_super_nova
signal laser_shot(laser_scene, location)
signal killed
signal delete_shield
signal hit
signal bomb_camera_shake

@export var speed = 350
@export var rate_of_fire := 0.35 
@export var friction: float = 10.0 

@onready var muzzle1 = $DoubleShot1
@onready var muzzle2 = $DoubleShot2
@onready var muzzle = $Muzzle
@onready var hit_sound = $"../SFX/HitSound"

var health_pause = false
var fire_super_nova = false
var double_shot = false
var index = 0
var shield_super_nova = false
var movement = true
var fire_upgrade = 0
var speed_upgrade = 1.00
var fire_rate_upgrade = 1.00
var laser_scene = preload("res://scenes/laser.tscn")
var shielded
var shoot_cd := false

func _ready():
	shielded = false

func _process(_delta):
	send_location.emit(global_position.x, global_position.y)
	if Input.is_action_pressed("boost"):
		speed = 450 * speed_upgrade
	else:
		if speed != 500:
			speed = 350 * speed_upgrade
	if Input.is_action_pressed("shoot") and !shoot_cd:
		start_shoot_cooldown()

func start_shoot_cooldown() -> void:
	shoot_cd = true
	shoot()
	await get_tree().create_timer(rate_of_fire * fire_rate_upgrade).timeout
	shoot_cd = false

func _physics_process(delta):
	if movement:
		var direction = Vector2(
			Input.get_axis("left", "right"), 
			Input.get_axis("up", "down")
		)
		var target_velocity = direction * speed * speed_upgrade
		velocity = velocity.lerp(target_velocity, friction * delta)
		move_and_slide()
		global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)
func shoot():
	Stats.save_game()
	Stats.shoot_bullet.emit()
	Stats.bullets_fired += 1
	if movement:
		if double_shot == false:
			laser_shot.emit(laser_scene, muzzle.global_position)
		else:
			laser_shot.emit(laser_scene, muzzle1.global_position)
			laser_shot.emit(laser_scene, muzzle2.global_position)

func die():
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				speed = 500
				rate_of_fire = 0.15
				await get_tree().create_timer(1.5).timeout
				rate_of_fire = 0.35
				speed = 350

func _on_shooting_enemy_1_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")

func _on_enemy_laser_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")

func _on_shooting_enemy_2_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")

func _on_power_up_collect() -> void:
	rate_of_fire = 0.20
	if fire_super_nova:
		double_shot = true
	await get_tree().create_timer(5.0 + fire_upgrade).timeout
	double_shot = false
	rate_of_fire = 0.35

func _on_shield_active() -> void:
	shielded = true

func _on_shield_deactive() -> void:
	shielded = false

func _on_fuel_bar_tank_empty() -> void:
	killed.emit()
	queue_free()

func _on_heart_3_die() -> void:
	killed.emit()
	queue_free()

func _on_button_buy(cost: Variant) -> void:
	fire_rate_upgrade -= 0.05

func _on_button_buy_speed(cost: Variant) -> void:
	speed_upgrade += 0.025

func _on_button_buy_fire(cost: Variant) -> void:
	fire_upgrade += 1

func _on_wave_counter_open_shop() -> void:
	movement = false
	global_position = Vector2(271, 870)

func _on_exit_pressed() -> void:
	movement = true

func _on_button_buyfire(cost: Variant) -> void:
	fire_rate_upgrade -= 0.05

func _on_button_pick_shield() -> void:
	shield_super_nova = true
	fire_super_nova = false
	print("shield super nova")
	score_super_nova.emit()

func _on_button_pick_fire() -> void:
	fire_super_nova = true
	shield_super_nova = false
	print("fire super nova")
	score_super_nova.emit()

func _on_button_pick_score() -> void:
	fire_super_nova = false
	shield_super_nova = false
	print("score super nova")

func _on_wave_counter_pause_health() -> void:
	health_pause = true

func _on_wave_counter_unpause_health() -> void:
	health_pause = false


func _on_tank_enemy_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")

func _on_suicider_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
				hit.emit()
		elif shield_super_nova == false: 
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")
		else:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")


func _on_bomber_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff") 

func take_damage():
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			hit.emit()
			bomb_camera_shake.emit()
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				bomb_camera_shake.emit()
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff") 
				bomb_camera_shake.emit()

func _on_flamethrower_player_die() -> void:
	if health_pause == false:
		if shielded == false:
			if GlobalMemory2.toggle_state == true:
				hit_sound.play()
			delete_shield.emit()
			shielded = false
			print("buff")
		else:
			if shield_super_nova == false:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
			else:
				if GlobalMemory2.toggle_state == true:
					hit_sound.play()
				delete_shield.emit()
				shielded = false
				print("buff")
