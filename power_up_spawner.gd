extends Node2D

var active = true
var pick_random

signal score
signal reload
signal shield

func _ready():
	await get_tree().create_timer(10).timeout
	pick()
	while true:
		await get_tree().create_timer(25).timeout
		pick()

func pick():
	if active:
		pick_random = randi_range(1, 3)
		if pick_random == 1:
			reload.emit()
		elif pick_random == 2:
			score.emit()
		else:
			shield.emit()

func _on_wave_counter_pause_power_ups() -> void:
	active = false
	print("pause")

func _on_wave_counter_unpause_power_ups() -> void:
	active = true
	print("unpause")
