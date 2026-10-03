extends Camera2D

@export var decay : float = 0.8  
@export var max_offset : Vector2 = Vector2(15, 15)  

var shake_amount : float = 0.0

func _process(delta: float) -> void:
	if shake_amount > 0:
		shake_amount = max(shake_amount - decay * delta, 0)
		_shake_screen()
	else:
		offset = Vector2.ZERO

func _shake_screen() -> void:
	var amount = pow(shake_amount, 2)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

func add_shake(strength: float) -> void:
	shake_amount = min(shake_amount + strength, 1.0)

func _on_player_hit() -> void:
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(0.6)

func _on_game_screen_shake() -> void:
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(0.2)


func _on_shooting_enemy_1_screen_shake() -> void:
	print("hit")
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(0.2)


func _on_tank_enemy_screen_shake() -> void:
	print("hit")
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(0.2)

func _on_suicider_screen_shake() -> void:
	print("hit")
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(0.2)

func _on_player_bomb_camera_shake() -> void:
	print("hit")
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(1)

func shake_camera():
	print("hit")
	var camera = get_tree().current_scene.get_node("Camera2D")
	if camera:
		camera.add_shake(1)
