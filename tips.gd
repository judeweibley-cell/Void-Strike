extends Label

@onready var timer = $"../TipTimer"

var inbetween_time = 0
var max_tip = 12
var min_tip = 1
var tip_number = 1
var pre_number = 3

func _ready():
	new_tip()
	start_constant_swing()

func new_tip():
	tip_number = randi_range(min_tip, max_tip)

	if pre_number == tip_number:
		new_tip()
		return 

	pre_number = tip_number

	if tip_number == 1:
		text = "Don't like your keybinds?
You can change them in settings."
	elif tip_number == 2:
		text = "3005 lines of code!"
	elif tip_number == 3:
		text = "Created for the HackClub Stardance Challenge!"
	elif tip_number == 4:
		text = "I'm really starting to run out of ideas here."
	elif tip_number == 5:
		text = "Join the Discord!"
	elif tip_number == 6:
		text = "What's your highscore?"
	elif tip_number == 7:
		text = "Fun Fact:
			8 + 6 = 14"
	elif tip_number == 7:
		text = "Please like
		this project took forever"
	elif tip_number == 8:
		text = "Fun Fact: 
			There are more possible chess games
			than atoms in the observable universe!"
	elif tip_number == 9:
		text = "Fun Fact:
			A day on Venus is longer than a year on Venus"
	elif tip_number == 10:
		text = "Fun Fact:
		All the planets could fit between Earth and the Moon."
	elif tip_number == 11:
		text = "Fun Fact:
		The Sun holds 99.86% of all the mass
		in our entire solar system."
	elif tip_number == 12:
		text = "Fun Fact:
		Venus is hotter than Mercury, 
		despite being farther from the Sun."

func start_constant_swing():
	pivot_offset = size / 2
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation_degrees", 4, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation_degrees", -4, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_tip_timer_timeout() -> void:
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await fade_tween.finished
	text = ""
	await get_tree().create_timer(inbetween_time).timeout
	new_tip()
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(self, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
