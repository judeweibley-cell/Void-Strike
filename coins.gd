extends Label

signal bought_upgrade
signal collected_coin
signal send_coin_value

var coins = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	text = "COINS: " + str(coins)

func _on_coin_collect() -> void:
	coins += 1
	Stats.coins += 1
	Stats.save_game()
	collected_coin.emit(Stats.coins)
	send_coin_value.emit(Stats.coins)

func _register_upgrade_purchase() -> void:
	Stats.upgrades_bought += 1
	Stats.save_game()
	bought_upgrade.emit()

func _on_button_refuel() -> void:
	coins -= 1
	send_coin_value.emit(coins)
	_register_upgrade_purchase()

func _on_button_buy(cost: Variant) -> void:
	print(cost)
	coins -= cost
	send_coin_value.emit(coins)
	_register_upgrade_purchase()

func _on_button_buyfire(cost: Variant) -> void:
	print(cost)
	coins -= cost
	send_coin_value.emit(coins)
	_register_upgrade_purchase()

func _on_button_buy_speed(cost: Variant) -> void:
	print(cost)
	if coins >= cost:
		coins -= cost
		send_coin_value.emit(coins)
		_register_upgrade_purchase()
	else:
		return

func _on_button_buy_score(cost: Variant) -> void:
	print(cost)
	coins -= cost
	send_coin_value.emit(coins)
	_register_upgrade_purchase()

func _on_button_buy_fire(cost: Variant) -> void:
	print(cost)
	coins -= cost
	send_coin_value.emit(coins)
	_register_upgrade_purchase()

func _on_button_buy_shield(cost: Variant) -> void:
	print(cost)
	coins -= cost
	send_coin_value.emit(coins)
	_register_upgrade_purchase()
