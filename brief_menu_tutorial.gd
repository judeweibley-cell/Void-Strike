extends Node2D

@onready var sound = $"../Typing sound"
@onready var label = $Label
@onready var characters = label.text.length()

var text = 0
var break_time = 0.04
var can_continue = false

const SAVE_PATH = "user://player_settings.cfg"

func _ready() -> void:
	if is_first_time_boot():
		save_first_boot_completed()
		show()
		label.visible_characters = 0
		await get_tree().create_timer(2).timeout
		for i in range(characters):
			await get_tree().create_timer(break_time).timeout
			label.visible_characters += 1
			sound.play()
			if label.visible_characters == characters:
				can_continue = true
	else:
		text = 4
		hide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if can_continue == true:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				print("The mouse was clicked somewhere on the screen!")
				new_text()
				can_continue = false

func new_text():
	text += 1
	if text == 1:
		label.text = "there's no explination \nneeded just explore\nand have fun\n\n(CLICK TO CONTINUE)"
		label.visible_characters = 0
		characters = label.text.length()
		await get_tree().create_timer(1).timeout
		for i in range(characters):
			await get_tree().create_timer(break_time).timeout
			label.visible_characters += 1
			sound.play()
			if label.visible_characters == characters:
				can_continue = true
	
	elif text == 2:
		label.text = "this is actually my first\ngame I've coded \non a real game engine\n\n(CLICK TO CONTINUE)"
		label.visible_characters = 0
		characters = label.text.length()
		await get_tree().create_timer(1).timeout
		for i in range(characters):
			await get_tree().create_timer(break_time).timeout
			label.visible_characters += 1
			sound.play()
			if label.visible_characters == characters:
				can_continue = true

	elif text == 3:
		label.text = "well anyways enough talk\nsee ya\n\n(CLICK TO CONTINUE)"
		label.visible_characters = 0
		characters = label.text.length()
		await get_tree().create_timer(1).timeout
		for i in range(characters):
			await get_tree().create_timer(break_time).timeout
			label.visible_characters += 1
			sound.play()
			if label.visible_characters == characters:
				can_continue = true

	elif text == 4:
		hide()

func is_first_time_boot() -> bool:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	if error != OK:
		return true
	return config.get_value("Player", "first_boot", true)

func save_first_boot_completed():
	var config = ConfigFile.new()
	config.set_value("Player", "first_boot", false)
	config.save(SAVE_PATH)
