extends ProgressBar

var score = 0
var shield = 0
var fire = 0

var DURATION: float = 5.0
var time_left: float = 0.0
var is_active: bool = false

func _ready() -> void:
	hide()
	value = 0.0 

func _process(delta: float) -> void:
	if is_active:
		show()
		time_left -= delta
		value = (time_left / DURATION) * 100.0
	if time_left <= 0.0:
		hide()
		value = 0.0
		is_active = false 

func _on_power_up_collect() -> void:
	DURATION = 5 + fire
	time_left = DURATION
	value = 100.0
	is_active = true
	Stats.power_ups_collected += 1
	Stats.save_game()

func _on_power_up_2_collect() -> void:
	DURATION = 15 + score
	time_left = DURATION
	value = 100.0
	is_active = true
	Stats.power_ups_collected += 1
	Stats.save_game()

func _on_power_up_3_collect() -> void:
	DURATION = 10 + shield
	time_left = DURATION
	value = 100.0
	is_active = true
	Stats.power_ups_collected += 1
	Stats.save_game()

func _on_player_delete_shield() -> void:
	hide()
	value = 0.0
	is_active = false

func _on_button_buy_score(cost: Variant) -> void:
	score += 1

func _on_button_buy_fire(cost: Variant) -> void:
	fire += 1

func _on_button_buy_shield(cost: Variant) -> void:
	shield += 1
