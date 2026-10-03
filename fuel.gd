extends Area2D

var min_x = 0.0
var max_x = 540.0
var is_active = false
var spawn_active = true

@export var speed = 150

func _ready():
	reset()

signal collect

func reset():
	var random_x = randf_range(min_x, max_x)
	global_position = Vector2(random_x, -100)
	await get_tree().create_timer(15).timeout
	if spawn_active:
		is_active = true
	else:
		reset()

func _physics_process(_delta):
	if is_active:
		global_position.y += speed * _delta

func _on_body_entered(body):
	if body is Player:
		reset()
		is_active = false
		collect.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	reset()
	is_active = false

func _on_wave_counter_unpause_power_ups() -> void:
	spawn_active = true

func _on_wave_counter_pause_power_ups() -> void:
	spawn_active = false
