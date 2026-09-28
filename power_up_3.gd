extends Area2D

var min_x = 0.0
var max_x = 540.0
var is_active = false

@export var speed = 150

signal collect

func reset():
	var random_x = randf_range(min_x, max_x)
	global_position = Vector2(random_x, -500)
	is_active = false

func _physics_process(_delta):
	if is_active:
		global_position.y += speed * _delta

func _on_body_entered(body):
	if body is Player:
		reset()
		collect.emit()
		reset()

func _on_power_up_spawner_shield() -> void:
	print("signal valid 3")
	reset()
	is_active = true
