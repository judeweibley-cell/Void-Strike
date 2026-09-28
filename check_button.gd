
extends CheckButton

@onready var click_sound = $"../../ClickSound"

func _ready() -> void:
	if GlobalMemory.is_first_boot == true:
		GlobalMemory.toggle_state = true  
		GlobalMemory.is_first_boot = false
	
	button_pressed = GlobalMemory.toggle_state
	toggled.connect(_on_button_toggled)

func _on_button_toggled(is_now_on: bool) -> void:
	release_focus()
	click_sound.play()
	GlobalMemory.toggle_state = is_now_on
