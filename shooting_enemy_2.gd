extends Area2D
class_name Shooting2

var introduction_wave = 3
var wave_number = 1
var enemy_spawn = false
var min_x = 0.0
var max_x = 540.0
var loop_active = false
var spawn_delay = 3
var enemy_laser_scene = preload("res://scenes/enemy_laser.tscn")

@onready var Laser = $"."
@onready var muzzle = $EnemyMuzzle2
@onready var hit_sound = $"../SFX/HitSound"

@export var pos = global_position
@export var speed = 400
@export var hp = 1

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
		await get_tree().create_timer(0.75).timeout
		if loop_active:
			shoot()

func shoot():
	enemy_laser_shot.emit(enemy_laser_scene, muzzle.global_position)

func reset():
	var sprite_position = $Sprite2D.global_position 
	coin.emit(sprite_position)
	$".".hide()
	var random_x = randf_range(min_x, max_x)
	global_position = Vector2(random_x, -2000)
	await get_tree().create_timer(spawn_delay).timeout
	$".".show()
	hp = 1
	
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
					reset()

func damage():
	if GlobalMemory2.toggle_state == true:
		hit_sound.play()
	killed.emit()
	reset()

func _on_area_entered(area: Area2D) -> void:
	if area is Laser:
		if enemy_spawn:
			damage()
			area.queue_free()

func _on_wave_counter_unpause_enemies() -> void:
	enemy_spawn = true
	reset()

func _on_wave_counter_pause_enemies() -> void:
	enemy_spawn = false
	off_screen.emit()

func _on_wave_counter_wave_number(wave: Variant) -> void:
	wave_number = wave
	
	
	
	
	
	
	
	
	
	
