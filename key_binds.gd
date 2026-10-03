extends Node2D

const SAVE_PATH = "user://keybinds.cfg"

var current_action: String = ""

var assigned_keybinds: Dictionary = {
	"up": "W",
	"down": "S",
	"left": "A",
	"right": "D",
	"shoot": "Space",
	"boost": "Shift",
	"reset": "R"
}

func _ready() -> void:
	load_keybinds()
	set_process_input(false)
	$Up.focus_mode = Control.FOCUS_NONE
	$Down.focus_mode = Control.FOCUS_NONE
	$Left.focus_mode = Control.FOCUS_NONE
	$Right.focus_mode = Control.FOCUS_NONE
	$Shoot.focus_mode = Control.FOCUS_NONE
	$Boost.focus_mode = Control.FOCUS_NONE
	$ResetGame.focus_mode = Control.FOCUS_NONE
	update_all_button_texts()
	GlobalInput.active_binds = assigned_keybinds.duplicate()
	GlobalInput.update_godot_input_map()

func save_keybinds() -> void:
	var config = ConfigFile.new()
	for action in assigned_keybinds.keys():
		config.set_value("Keybinds", action, assigned_keybinds[action])
	var error = config.save(SAVE_PATH)
	if error != OK:
		print("Failed to save keybinds. Error code: ", error)
	else:
		print("Keybinds successfully saved to disk!")

func load_keybinds() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	if error != OK:
		print("No saved keybinds found. Using defaults.")
		return
	for action in assigned_keybinds.keys():
		if config.has_section_key("Keybinds", action):
			assigned_keybinds[action] = config.get_value("Keybinds", action)
	print("Keybinds successfully loaded from disk!")

func _on_up_pressed() -> void:
	current_action = "up"
	$Up/Key.text = "__"
	set_process_input(true)

func _on_down_pressed() -> void:
	current_action = "down"
	$Down/Key.text = "__"
	set_process_input(true)

func _on_left_pressed() -> void:
	current_action = "left"
	$Left/Key.text = "__"
	set_process_input(true)

func _on_right_pressed() -> void:
	current_action = "right"
	$Right/Key.text = "__"
	set_process_input(true)

func _on_shoot_pressed() -> void:
	current_action = "shoot"
	$Shoot/Key.text = "__"
	set_process_input(true)

func _on_boost_pressed() -> void:
	current_action = "boost"
	$Boost/Key.text = "__"
	set_process_input(true)

func _input(event: InputEvent) -> void:
	var input_name: String = ""
	var valid_input: bool = false
	if event is InputEventKey and event.is_pressed():
		input_name = OS.get_keycode_string(event.physical_keycode)
		valid_input = true
	elif event is InputEventMouseButton and event.is_pressed():
		input_name = get_mouse_button_string(event.button_index)
		valid_input = true
	if valid_input:
		var is_duplicate: bool = false
		for action in assigned_keybinds.keys():
			if action == current_action:
				continue
			if assigned_keybinds[action] == input_name:
				is_duplicate = true
				break
		if is_duplicate:
			print("Input '", input_name, "' is already assigned!")
			set_process_input(false)
			update_button_text(current_action, assigned_keybinds[current_action])
			current_action = ""
			get_viewport().set_input_as_handled()
			return
		set_process_input(false)
		print("Action '", current_action, "' successfully set to: ", input_name)
		assigned_keybinds[current_action] = input_name
		update_button_text(current_action, input_name)
		GlobalInput.active_binds[current_action] = input_name
		GlobalInput.update_godot_input_map()
		save_keybinds()
		current_action = ""
		get_viewport().set_input_as_handled()

func get_mouse_button_string(button_idx: int) -> String:
	match button_idx:
		MOUSE_BUTTON_LEFT: return "Left Click"
		MOUSE_BUTTON_RIGHT: return "Right Click"
		MOUSE_BUTTON_MIDDLE: return "Middle Click"
		_: return "Middle Click"

func update_button_text(action: String, text_to_display: String) -> void:
	match action:
		"up": $Up/Key.text = text_to_display
		"down": $Down/Key.text = text_to_display
		"left": $Left/Key.text = text_to_display
		"right": $Right/Key.text = text_to_display
		"shoot": $Shoot/Key.text = text_to_display
		"boost": $Boost/Key.text = text_to_display
		"reset": $ResetGame/Key.text = text_to_display

func update_all_button_texts() -> void:
	$Up/Key.text = assigned_keybinds["up"]
	$Down/Key.text = assigned_keybinds["down"]
	$Left/Key.text = assigned_keybinds["left"]
	$Right/Key.text = assigned_keybinds["right"]
	$Shoot/Key.text = assigned_keybinds["shoot"]
	$Boost/Key.text = assigned_keybinds["boost"]
	$ResetGame/Key.text = assigned_keybinds["reset"]

func _on_reset_pressed() -> void:
	set_process_input(false)
	current_action = ""
	
	assigned_keybinds = {
		"up": "W",
		"down": "S",
		"left": "A",
		"right": "D",
		"shoot": "Space",
		"boost": "Shift",
		"reset": "R"
	}
	
	update_all_button_texts()
	
	GlobalInput.active_binds = assigned_keybinds.duplicate()
	GlobalInput.update_godot_input_map()
	save_keybinds()

func _on_reset_game_pressed() -> void:
	current_action = "reset"
	$ResetGame/Key.text = "__"
	set_process_input(true)
