extends Button

var notes_visible = false

@onready var target_panel: Panel = $"../NotesPanel"

func _ready() -> void:
	target_panel.hide()

func _on_pressed() -> void:
	release_focus()
	print("notes")
	
	if notes_visible == false:
		target_panel.show()
		notes_visible = true
	else:
		target_panel.hide()
		notes_visible = false


func _on_exit_notes_pressed() -> void:
		release_focus()
		target_panel.hide()
		notes_visible = false

func _on_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_exit_notes_mouse_entered() -> void:
	$"../ClickSound".play()
