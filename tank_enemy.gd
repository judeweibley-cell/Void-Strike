extends Area2D

var enemy_spawn = false
var introduction_wave = 5
var wave_number = 1
var min_x = 0.0
var max_x = 540.0
var loop_active = false
var spawn_delay = 2.0
var enemy_laser_scene = preload("res://scenes/enemy_laser.tscn")

@onready var Laser = $"."
@onready var muzzle1 = $"Muzzle 1"
@onready var muzzle2 = $"Muzzle 2"
@onready var hit_sound = $"../SFX/HitSound"

@export var pos = global_position
@export var speed = 150
@export var hp = 5

signal screen_shake
signal spawned
signal off_screen
signal coin
signal enemy_laser_shot(enemy_laser_scene, location)
signal killed
signal hit
signal player_die

func _ready():
	reset()
	enemy_spawn = false
	
func start_shooting_loop():
	loop_active = true
	while loop_active:
		await get_tree().create_timer(1.5).timeout
		if loop_active:
			shoot()

func shoot():
	enemy_laser_shot.emit(enemy_laser_scene, muzzle1.global_position)
	enemy_laser_shot.emit(enemy_laser_scene, muzzle2.global_position)

func reset():
	var random_x = randf_range(min_x, max_x)
	global_position = Vector2(random_x, -500)
	$".".hide()
	await get_tree().create_timer(spawn_delay).timeout
	$".".show()
	hp = 5
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	reset()
	loop_active = false
	off_screen.emit()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	start_shooting_loop()
	spawned.emit()

func _physics_process(_delta):
	if wave_number >= introduction_wave:
		global_position.y += speed * _delta
	if enemy_spawn:
		if wave_number >= introduction_wave:
			show()
	else:
		hide()


func _on_body_entered(body):
	if body is Player:
		if enemy_spawn:
			if wave_number >= introduction_wave:
				if body.has_method("die"):
					player_die.emit()
					var random_x = randf_range(min_x, max_x)
					global_position = Vector2(random_x, -500)
					await get_tree().create_timer(spawn_delay).timeout
					hp = 5

func take_damage(amount):
	hp -= amount
	if GlobalMemory2.toggle_state == true:
		hit_sound.play()
	if hp <= 0:
		var sprite_position = $Sprite2D.global_position 
		coin.emit(sprite_position) 
		killed.emit()
		reset()
	else:
		hit.emit()
	screen_shake.emit()
	
func _on_area_entered(area: Area2D) -> void:
	var amount = 1
	if area is Laser:
		if enemy_spawn:
			take_damage(amount)
			area.queue_free()

func _on_wave_counter_wave_number(wave: Variant) -> void:
	wave_number = wave

func _on_wave_counter_pause_enemies() -> void:
	enemy_spawn = false

func _on_wave_counter_unpause_enemies() -> void:
	enemy_spawn = true
	reset()
