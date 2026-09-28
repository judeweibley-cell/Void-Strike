extends Control

var current_wave = 1

@onready var game_time = $Panel/Time
@onready var wave = $Panel/Wave

@onready var click_sound = $"../../SFX/ClickSound"

func _physics_process(delta: float) -> void:
	$Panel/Wave.text = "Wave: " + str(current_wave)


func set_score(value: int):
	$Panel/Score.text = "Score: " + str(value)

func set_high_score(value: int):
	$Panel/HighScore.text = "HighScore: " + str(value)

func _on_menu_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.18).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_restart_button_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.18).timeout
	get_tree().reload_current_scene()


func _on_wave_counter_send_wave(wave: Variant) -> void:
	current_wave = wave
	print(current_wave)
