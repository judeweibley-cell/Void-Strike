extends Button

var percent_missings
var coin = 0
var cost
var percent_refuel

signal refuel

func _physics_process(delta: float) -> void:
	if percent_missings == 0:
		text = "Sold Out"
		disabled = true
	else:
		text = "BUY: 1" 
		disabled = false

func _on_pressed() -> void:
	if coin > 0:
		coin - 1
		print("bought")
		refuel.emit()

func _on_wave_counter_open_shop() -> void:
	text = "BUY: 1" 

func _on_coins_send_coin_value(coins: Variant) -> void:
	coin = coins

func _on_fuel_bar_send_missing_value(percent_missing: Variant) -> void:
	percent_missings = percent_missing
