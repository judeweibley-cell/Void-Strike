class_name Enemy extends Area2D

signal exited
signal hit
signal killed
signal coin(pos)

@export var speed = 150
@export var hp = 1
@export var points = 100
@export var pos = global_position


func _physics_process(_delta):
	global_position.y += speed * _delta

func die():
	var sprite_position = $Sprite2D.global_position 
	coin.emit(sprite_position) 
	queue_free()

func _on_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()
			die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()

func _on_wave_counter_pause_enemies() -> void:
	queue_free()
	exited.emit()

func _on_wave_counter_delete_enemies() -> void:
	queue_free()
