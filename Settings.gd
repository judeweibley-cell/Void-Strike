extends Button

var settings_visible = false

@onready var target_panel: Panel = $"../SettingsPanel"

func _ready() -> void:
	target_panel.visible
	if target_panel:
		target_panel.visible = button_pressed

func _on_pressed() -> void:
	release_focus()
	print("settings")
	if settings_visible == false:
		$"../SettingsPanel".show()
		settings_visible = true
	else:
		$"../SettingsPanel".hide()
		settings_visible = false

func _on_button_pressed() -> void:
	release_focus()
	$"../SettingsPanel".hide()
	settings_visible = false

func _on_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_button_mouse_entered() -> void:
	$"../ClickSound".play()
