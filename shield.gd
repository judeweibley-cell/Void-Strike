extends Area2D

class_name Shield

signal active
signal deactive
signal shooting1_hit
signal shooting2_hit

var shield = 0

func _ready():
	hide()

func _on_power_up_3_collect() -> void:
	active.emit()
	show()
	await get_tree().create_timer(10 + shield).timeout
	deactive.emit()
	hide()
	

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("die"):
		area.die()

func _on_player_delete_shield() -> void:
	hide()

@export var follow_speed : float = 5.0 
@export var y_offset : float = 50.0
@export var max_lag_distance : float = 40.0 

@onready var player = get_parent()

func _physics_process(delta: float) -> void:
	if player:
		var target_position = player.global_position + Vector2(0, y_offset)
		var new_position = global_position.lerp(target_position, follow_speed * delta)
		var to_target = new_position - target_position
		if to_target.length() > max_lag_distance:
			new_position = target_position + to_target.limit_length(max_lag_distance)
		global_position = new_position

func _on_button_buy_shield(cost: Variant) -> void:
	shield += 1
