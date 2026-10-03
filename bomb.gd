extends Area2D

@export var speed: float = 50.0

signal damage
signal explode_player

func _ready() -> void:
	$Explosion/CollisionShape2D.set_deferred("disabled", false)
	start_bomb_sequence()

func _physics_process(delta: float) -> void:
	global_position.y += speed * delta

func start_bomb_sequence() -> void:
	show()
	$Sprite2D.self_modulate.a = 1.0
	await get_tree().create_timer(3.0).timeout
	$Sprite2D.self_modulate.a = 0.0
	if has_node("Explosion"):
		$Explosion.animate_explosion()
		$"../Camera2D".shake_camera()
		await get_tree().create_timer(0.3).timeout
		hide()
	else:
		hide()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	hide()
