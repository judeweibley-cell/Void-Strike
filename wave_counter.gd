extends Label

var wave_timer_finished: bool = false
var wave_time_up: bool = false
var check_loop = false
var check
var enemies_left
var wave_loop = true
var wave_length = 20
var wave = 0

signal send_wave
signal delete_enemies
signal unpause_health
signal pause_health
signal wave_number
signal pause_power_ups
signal unpause_power_ups
signal heal_player
signal unpause_fuel
signal pause_fuel
signal unpause_enemies
signal pause_enemies
signal open_shop

func _physics_process(delta: float) -> void:
	text = "~~WAVE: " + str(wave) + "~~"
	send_wave.emit(wave)

func _ready():
	start_waves()

func _on_enemy_died():
	enemies_left -= 1

func start_waves():
	pause_fuel.emit()
	wave += 1
	_check_and_save_highest_wave()
	pause_enemies.emit()
	fade_text_in()
	await get_tree().create_timer(3).timeout
	fade_text_out()
	unpause_enemies.emit()
	unpause_fuel.emit()
	new_wave()

func intermission():
	check = true
	pause_power_ups.emit()
	pause_fuel.emit()
	wave += 1
	_check_and_save_highest_wave()
	pause_enemies.emit()
	$"../Space Junk".stop_spawning()
	fade_text_in()
	await get_tree().create_timer(7).timeout
	pause_health.emit()
	open_shop.emit()

func fade_text_out(duration: float = 1.0) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration)
	await tween.finished
	hide()

func fade_text_in(duration: float = 1.0) -> void:
	modulate.a = 0.0
	show()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)

func _on_exit_pressed() -> void:
	delete_enemies.emit()
	await get_tree().create_timer(3).timeout
	unpause_health.emit()
	fade_text_out()
	unpause_enemies.emit()
	unpause_fuel.emit()
	unpause_power_ups.emit()
	new_wave()
	send_wave.emit(wave)
	$"../Space Junk".start_spawning()

func _on_game_send_enemies(enemies: Variant) -> void:
	enemies_left = enemies

func new_wave():
	if wave == 0:
		wave = 1
		_check_and_save_highest_wave()
	wave_number.emit(wave)
	await get_tree().create_timer(wave_length).timeout
	intermission()

func _check_and_save_highest_wave() -> void:
	if wave > Stats.highest_wave:
		Stats.highest_wave = wave
		Stats.save_game()
