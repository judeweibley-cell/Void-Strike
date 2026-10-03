extends Sprite2D

signal die

var max_hearts = 3
var health = 3

func _ready():
	health = 3
 
func _physics_process(delta: float) -> void:
	update_ui()
	if health == 0:
		$"../Heart1".hide()
		die.emit()

func _on_player_hit() -> void:
	health -= 1
	update_ui()

func _on_button_buy(cost: Variant) -> void:
	health += 1
	max_hearts += 1
	update_ui()

func _on_button_buy_2(cost: Variant) -> void:
	health = 5
	max_hearts = 5
	update_ui()

func update_ui():
	if health == 2:
		$".".hide()
		$"../Heart4".hide()
		$"../Heart5".hide()
		$"../Heart1".show()
		$"../Heart2".show()
	if health == 1:
		$"../Heart2".hide()
		$".".hide()
		$"../Heart4".hide()
		$"../Heart5".hide()
		$"../Heart1".show()
	if health == 3:
		$"../Heart4".hide()
		$"../Heart5".hide()
		$".".show()
		$"../Heart2".show()
		$"../Heart1".show()
	if health == 4:
		$"../Heart5".hide()
		$"../Heart1".show()
		$"../Heart2".show()
		$".".show()
		$"../Heart4".show()
	if health == 5:
		$"../Heart1".show()
		$"../Heart2".show()
		$".".show()
		$"../Heart4".show()
		$"../Heart5".show()

func _on_wave_counter_open_shop() -> void:
	health += 1
	if health > max_hearts:
		health = max_hearts
	update_ui()
