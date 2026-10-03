extends Area2D

signal spawn_bomb
signal coin(pos: Vector2)
signal update_block_status
signal screen_shake
signal hit
signal killed
signal player_die

const BOMB_SCENE = preload("res://scenes/bomb.tscn")

@export var speed: float = 250.0
@export var hp: int = 4

@export var spawn_cooldown: float = 3.0
@export var spawn_warmup: float = 2.0

var shooting = false
var current_wave: int = 1
var introduction_wave: int = 15 
var collision_active: bool = true
var is_spawning_enabled: bool = true  
var min_x: float = 0.0
var max_x: float = 540.0

var is_warming_up: bool = false       
var current_timer_id: int = 0

@onready var collision_polygon = $CollisionPolygon2D
@onready var sprite = $Sprite2D
@onready var screen_height: float = get_viewport_rect().size.y


func _ready() -> void:
	if collision_polygon:
		collision_polygon.set_deferred("disabled", false)
	reset()


func _physics_process(delta: float) -> void:
	if not collision_active or is_warming_up:
		return
		
	if current_wave >= introduction_wave:
		global_position.y += speed * delta
		if global_position.y > screen_height + 150.0:
			reset()

func damage(amount: int) -> void:
	if not collision_active:
		return
	print("Hit bomber! HP remaining: ", hp)
	hp -= amount
	if hp <= 0:
		var sprite_position = sprite.global_position if sprite else global_position
		coin.emit(sprite_position)
		killed.emit()
		remove_and_cooldown()
	else:
		hit.emit()
		screen_shake.emit()


func remove_and_cooldown() -> void:
	collision_active = false
	if collision_polygon:
		collision_polygon.set_deferred("disabled", true)
	hide()
	current_timer_id += 1
	var local_id = current_timer_id
	await get_tree().create_timer(spawn_cooldown).timeout
	if local_id != current_timer_id:
		return
		
	if is_spawning_enabled:
		prepare_spawn()

func prepare_spawn() -> void:
	current_timer_id += 1
	var local_id = current_timer_id
	var random_x = randf_range(min_x, max_x)
	global_position = Vector2(random_x, -100.0)
	hp = 4
	is_warming_up = true
	if current_wave >= introduction_wave:
		if sprite:
			sprite.self_modulate.a = 1.0
		show()
		await get_tree().create_timer(spawn_warmup).timeout
		if local_id != current_timer_id:
			return
		if is_spawning_enabled:
			is_warming_up = false
			collision_active = true
			if collision_polygon:
				collision_polygon.set_deferred("disabled", false)
	else:
		hide()


func reset() -> void:
	is_warming_up = false
	prepare_spawn()

func _on_wave_counter_pause_enemies() -> void:
	is_spawning_enabled = false  
	
	if not collision_active:
		is_warming_up = false
		current_timer_id += 1 
		hide()

func _on_wave_counter_unpause_enemies() -> void:
	is_spawning_enabled = true
	current_timer_id += 1
	var local_id = current_timer_id
	await get_tree().create_timer(spawn_cooldown).timeout
	if local_id == current_timer_id and is_spawning_enabled:
		prepare_spawn()

func _on_body_entered(body: Node2D) -> void:
	if not collision_active or is_warming_up:
		return
	if body.is_in_group("Player") or body.name == "Player":
		collision_active = false
		player_die.emit()
		remove_and_cooldown()

func _on_wave_counter_wave_number(wave: int) -> void:
	current_wave = wave

func _on_wave_counter_open_shop() -> void:
	_on_wave_counter_pause_enemies()

func _on_exit_pressed() -> void:
	is_spawning_enabled = true
	reset()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	shooting = true
	print(shooting)
	$ShootTimer.start()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	shooting = false
	print(shooting)
	$ShootTimer.stop()

func _on_shoot_timer_timeout() -> void:
	if shooting:
		print("shoot bomb")
		shoot_bomb()
		spawn_bomb.emit()

func shoot_bomb() -> void:
	if BOMB_SCENE:
		var new_bomb = BOMB_SCENE.instantiate()
		new_bomb.global_position = global_position
		get_parent().add_child(new_bomb)
