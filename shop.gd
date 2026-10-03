extends Panel

func _ready():
	hide()
	$PowerUpUpgrades.hide()
	$ShipUpgrades.show()

func _pressed() -> void:
	hide()

func _on_wave_counter_open_shop() -> void:
	show()

func _on_exit_pressed() -> void:
	hide()
	$PowerUpUpgrades.hide()
	$ShipUpgrades.show()

func _on_ship_tab_pressed() -> void:
	$ShipUpgrades.show()
	$PowerUpUpgrades.hide()

func _on_power_ups_tab_pressed() -> void:
	$ShipUpgrades.hide()
	$PowerUpUpgrades.show()
