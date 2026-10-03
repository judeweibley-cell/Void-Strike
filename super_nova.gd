extends Button

var pick = false
var shield = false
var score = false
var fire = false

signal reset
signal super_nova

func _ready() -> void:
	text = "Locked"
	disabled = true
	$"../../../ColorRect".hide()
	
func _physics_process(delta: float) -> void:
	if shield:
		if score:
			if fire:
				if pick == false:
					text = "[Empty]"
					disabled = false

func _on_pressed() -> void:
	$"../../../ColorRect".show()
	super_nova.emit()

func _on_button_maxed_score() -> void:
	score = true

func _on_button_maxed_fire() -> void:
	fire = true

func _on_button_max_shield() -> void:
	shield = true

func _on_button_pick_score() -> void:
	pick = true
	print("signal valid")
	text = "Score"
	disabled = false
	$"../../../ColorRect".hide()
	reset.emit()

func _on_button_pick_fire() -> void:
	pick = true
	print("signal valid")
	text = "Fire"
	disabled = false
	$"../../../ColorRect".hide()
	reset.emit()
	
func _on_button_pick_shield() -> void:
	pick = true
	print("signal valid")
	text = "Shield"
	disabled = false
	$"../../../ColorRect".hide()
	reset.emit()

func _on_exit_pressed() -> void:
	reset.emit()
	$"../../../ColorRect".hide()
