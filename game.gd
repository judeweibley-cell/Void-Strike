extends Node2D

signal enemy_killed

@export var enemy_scenes: Array[PackedScene] = []
@export var power_up_scenes: Array[PackedScene] = []

@onready var enemy_laser_container = $EnemyLaserContainer
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var PowerUp_timer = $PowerUpSpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var PowerUp_container = $PowerUpContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var pb = $ParallaxBackground
@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound
@onready var click_sound = $SFX/ClickSound

signal screen_shake
signal send_enemies
signal EnemySpawn
signal coin

var wave_number = 1
var enemies = 0
var score_multiplier = 1
var score_super_nova = false
var score_upgrade = 0
var enemy_spawn = false
var twoX_score = false
var player = null
var score := 0:
	set(value):
		score = value
		if hud:
			hud.score = score
var high_score
var scroll_speed = 100


func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	hud.score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	var difficulty = 0.0055
	if timer.wait_time > difficulty:
		timer.wait_time = (100 - wave_number) * difficulty
	elif timer.wait_time < difficulty:
		timer.wait_time = difficulty

	pb.scroll_offset.y += delta * scroll_speed
	send_enemies.emit(enemies)
	Stats.highscore = high_score
	
	
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	if GlobalMemory2.toggle_state == true:
		laser_sound.play()

func _on_shooting_enemy_1_enemy_laser_shot(enemy_laser_scene, location):
	var enemy_laser = enemy_laser_scene.instantiate()
	enemy_laser.global_position = location
	enemy_laser_container.add_child(enemy_laser)
	if GlobalMemory2.toggle_state == true:
		laser_sound.play()

func _on_enemy_spawn_timer_timeout():
	if enemy_spawn:
		var e = enemy_scenes.pick_random().instantiate()
		e.global_position = Vector2(randf_range(-170, 250), -150)
		e.killed.connect(_on_enemy_killed)
		e.hit.connect(_on_enemy_hit)
		e.coin.connect($Coin_spawner._on_enemy_coin)
		enemy_container.add_child(e)
		enemies += 1
		print(enemies)
	else:
		pass

func _on_enemy_killed(points):
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	coin.emit()
	if GlobalMemory2.toggle_state == true:
		hit_sound.play()
	if twoX_score == true:
		score += points * 2 * score_multiplier
	else:
		score += points * score_multiplier
	if score > high_score:
		high_score = score
	enemies -= 1
	screen_shake.emit()

func _on_enemy_hit():
	if GlobalMemory2.toggle_state == true:
		hit_sound.play()
	if score_super_nova:
		score_multiplier + 0.5
		print(score_multiplier)
	screen_shake.emit()

func _on_player_killed():
	if GlobalMemory2.toggle_state == true:
		explode_sound.play()
	gos.set_score(score)
	gos.set_high_score(high_score)
	save_game()
	
	await get_tree().create_timer(1).timeout
	gos.visible = true

func _on_shooting_enemy_1_killed() -> void:
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	if twoX_score == true:
		score += 300 * score_multiplier
	else:
		score += 150 * score_multiplier
	if GlobalMemory2.toggle_state == true:
		if hit_sound:
			hit_sound.play()
	if hud and score > high_score:
		high_score = score
		hud.high_score = high_score
	enemies -= 1
	screen_shake.emit()

func _on_shooting_enemy_2_killed() -> void:
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	if twoX_score == true:
		score += 500 * score_multiplier
	else:
		score += 250 * score_multiplier
	if GlobalMemory2.toggle_state == true:
		if hit_sound:
			hit_sound.play()
	if hud and score > high_score:
		high_score = score
		hud.high_score = high_score
	enemies -= 1
	screen_shake.emit()
	
	
func _on_shooting_enemy_2_enemy_laser_shot(enemy_laser_scene: Variant, location: Variant) -> void:
	var enemy_laser = enemy_laser_scene.instantiate()
	enemy_laser.global_position = location
	enemy_laser_container.add_child(enemy_laser)
	if GlobalMemory2.toggle_state == true:
		laser_sound.play()

func _on_power_up_2_collect() -> void:
	twoX_score = true
	await get_tree().create_timer(15 + score_upgrade).timeout
	twoX_score = false
	score_multiplier = 1

func _on_coin_spawner_spawn() -> void:
	var new_coin = preload("res://scenes/Coin.tscn").instantiate()
	$Coin_spawner.add_child(new_coin)
	new_coin.global_position = $Coin_spawner.global_position

func _on_wave_counter_pause_enemies() -> void:
	enemy_spawn = false

func _on_wave_counter_unpause_enemies() -> void:
	enemy_spawn = true

func _on_button_buy_score(cost: Variant) -> void:
	score_upgrade += 1

func _on_button_pick_score() -> void:
	score_super_nova = true
	score_multiplier = 2

func _on_player_score_super_nova() -> void:
	score_super_nova = false
	score_multiplier = 1

func _on_enemy_exited() -> void:
	enemies -= 1

func _on_shooting_enemy_2_off_screen() -> void:
	enemies -= 1

func _on_shooting_enemy_1_off_screen() -> void:
	enemies -= 1

func _on_shooting_enemy_2_spawned() -> void:
	enemies += 1

func _on_shooting_enemy_1_spawned() -> void:
	enemies += 1

func _on_wave_counter_wave_number(wave: Variant) -> void:
	wave_number = wave

func _on_tank_enemy_killed() -> void:
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	if twoX_score == true:
		score += 800 * score_multiplier
	else:
		score += 400 * score_multiplier

	if GlobalMemory2.toggle_state == true:
		if hit_sound:
			hit_sound.play()
		
	if hud and score > high_score:
		high_score = score
		hud.high_score = high_score
	enemies -= 1
	screen_shake.emit()

func _on_tank_enemy_enemy_laser_shot(enemy_laser_scene: Variant, location: Variant) -> void:
	var enemy_laser = enemy_laser_scene.instantiate()
	enemy_laser.global_position = location
	enemy_laser_container.add_child(enemy_laser)
	if GlobalMemory2.toggle_state == true:
		laser_sound.play()

func _on_horde_spawner_spawn_horde() -> void:
	if enemy_spawn:
		var horde_position = randf_range(-170, 250)
		var seperation = 70
		for i in range(5):
			var e = enemy_scenes[5].instantiate()
			e.global_position = Vector2(horde_position, -150 - (i * seperation))
			
			e.killed.connect(_on_enemy_killed)
			e.hit.connect(_on_enemy_hit)
			e.coin.connect($Coin_spawner._on_enemy_coin)
			enemy_container.add_child(e)
			enemies += 1
			print(enemies)

func _on_asteroid_field_spawner_spawn_asteroid_field() -> void:
	print("asteroid field")
	if enemy_spawn:
		var seperation = 120
		for i in range(5):
			var e = enemy_scenes[9].instantiate()
			var horde_position = randf_range(-170, 250)
			e.global_position = Vector2(horde_position, -150 - (i * seperation))
			e.killed.connect(_on_enemy_killed)
			e.hit.connect(_on_enemy_hit)
			e.coin.connect($Coin_spawner._on_enemy_coin)
			enemy_container.add_child(e)
			enemies += 1
			print(enemies)

func _on_suicider_killed() -> void:
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	if twoX_score == true:
		score += 600 * score_multiplier
	else:
		score += 300 * score_multiplier
	if GlobalMemory2.toggle_state == true:
		if hit_sound:
			hit_sound.play()
	if hud and score > high_score:
		high_score = score
		hud.high_score = high_score
	enemies -= 1
	screen_shake.emit()

func _on_suicider_hit() -> void:
	hit_sound.play()

func _on_bomber_hit() -> void:
	hit_sound.play()

func _on_bomber_killed() -> void:
	Stats.save_game()
	Stats.enemies_defeated += 1
	Stats.enemy_killed.emit()
	if twoX_score == true:
		score += 600 * score_multiplier
	else:
		score += 300 * score_multiplier
	if GlobalMemory2.toggle_state == true:
		if hit_sound:
			hit_sound.play()
	if hud and score > high_score:
		high_score = score
		hud.high_score = high_score
	enemies -= 1
	screen_shake.emit()

func _on_bomb_damage() -> void:
	print("signal to main game Valid!!!!!!!!!!!!!!")
