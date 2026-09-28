extends CheckButton

@onready var click_sound = $"../../ClickSound"

func _ready() -> void:
	if GlobalMemory2.is_first_boot == true:
		GlobalMemory2.toggle_state = true 
		GlobalMemory2.is_first_boot = false
	button_pressed = GlobalMemory2.toggle_state
	toggled.connect(_on_button_toggled)

func _on_button_toggled(is_now_on: bool) -> void:
	release_focus()
	click_sound.play()
	GlobalMemory2.toggle_state = is_now_on
