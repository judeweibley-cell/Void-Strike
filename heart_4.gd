extends Sprite2D

func _ready():
	hide()


func _on_button_buy(cost: Variant) -> void:
	show()

func _on_heart_3_hit_4() -> void:
	hide()
