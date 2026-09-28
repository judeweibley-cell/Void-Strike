extends Node

var active_binds: Dictionary = {
	"up": "W",
	"down": "S",
	"left": "A",
	"right": "D",
	"shoot": "Left Click", 
	"boost": "Shift"
}

func _ready() -> void:
	update_godot_input_map()

func update_godot_input_map() -> void:
	for action in active_binds.keys():
		var bind_value: String = active_binds[action]
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		else:
			InputMap.action_erase_events(action)
		var new_event: InputEvent
		
		if bind_value == "Left Click":
			var mouse_event = InputEventMouseButton.new()
			mouse_event.button_index = MOUSE_BUTTON_LEFT
			new_event = mouse_event
		elif bind_value == "Right Click":
			var mouse_event = InputEventMouseButton.new()
			mouse_event.button_index = MOUSE_BUTTON_RIGHT
			new_event = mouse_event
		elif bind_value == "Middle Click":
			var mouse_event = InputEventMouseButton.new()
			mouse_event.button_index = MOUSE_BUTTON_MIDDLE
			new_event = mouse_event
		else:
			var key_event = InputEventKey.new()
			key_event.physical_keycode = OS.find_keycode_from_string(bind_value)
			new_event = key_event
			
		if new_event:
			InputMap.action_add_event(action, new_event)
