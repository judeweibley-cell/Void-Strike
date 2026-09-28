extends Control

@onready var pb = $ParallaxBackground

var scroll_speed = 100

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_speed_purchase_pressed():
	print("Speed Purchased")

func _on_atk_speed_purchase_pressed():
	print("ATK Speed Purchased")

func _on_damage_purchase_pressed():
	print("Damage Purchased")

func _on_health_purchase_pressed():
	print("Health Purchased")

func _on_power_shot_purchase_pressed():
	print("Power Shot Purchased")

func _process(delta):
	pb.scroll_offset.y += delta * scroll_speed
