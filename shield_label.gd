extends Label

func _ready():
	text = "Increases the duration 
by 1 second"

func _on_button_super_nova() -> void:
	text = "When broken
	increases player
	stats for a short
	amount of time"

func _on_button_reset() -> void:
	text = "Increases the duration 
by 1 second"
