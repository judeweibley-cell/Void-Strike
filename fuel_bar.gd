extends ProgressBar

var percent_missing
var active = true
var boost = false

signal tank_empty
signal send_missing_value

func _process(delta):
	if not active:
		return

	boost = Input.is_action_pressed("boost")
	if boost:
		var burn_amount = 2.0 * delta
		value -= burn_amount
		Stats.fuel_burned += burn_amount
		send_missing()
	else:
		var burn_amount = 1.0 * delta
		value -= burn_amount
		Stats.fuel_burned += burn_amount
		send_missing()

	if value == 0.0:
		tank_empty.emit()
		

func _on_fuel_collect() -> void:
	value += 30
	send_missing()

func _on_player_killed() -> void:
	active = false
	Stats.save_game()

func _on_player_hit() -> void:
	value -= 20
	Stats.fuel_burned += 20.0
	Stats.save_game()
	send_missing()

func _on_wave_counter_pause_fuel() -> void:
	active = false

func _on_wave_counter_unpause_fuel() -> void:
	active = true

func send_missing():
	percent_missing = 100 - value
	send_missing_value.emit(percent_missing)

func _on_button_refuel() -> void:
	value += 10
	send_missing()
