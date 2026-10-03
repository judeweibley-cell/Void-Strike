extends Node2D

var number1 = false #15 minutes
var number2 = false #30 minutes
var number3 = false #60 minutes
var number4 = false #wave 5
var number5 = false #wave 15
var number6 = false #wave 30
var number7 = false #wave 50
var number8 = false #1000 enemies
var number9 = false #die 50 times
var number10 = false #die 100 times
var number11 = false #kill 2500 enemies
var number12 = false #kill 5000 enemies

func _on_log_panel_send_time(hours: int, minutes: int) -> void:
	if hours >= 1:
		number3 = true
	if number3 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 3/ProgressBar".value = minutes
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 3/Progress".text = "%d/60" % minutes
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 3/ProgressBar".value = 60
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 3/Progress".text = "60/60"
	if hours * 60 + minutes >= 30:
		number2 = true
	if number2 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 2/ProgressBar".value = minutes
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 2/Progress".text = "%d/30" % minutes
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 2/ProgressBar".value = 30
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 2/Progress".text = "30/30"
	if hours * 60 + minutes >= 15:
		number1 = true
	if number1 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 1/ProgressBar".value = minutes
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 1/Progress".text = "%d/15" % minutes
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 1/ProgressBar".value = 15
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 1/Progress".text = "15/15"

func _physics_process(delta: float) -> void:
	if Stats.highest_wave >= 5:
		number4 = true
	if number4 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 4/ProgressBar".value = Stats.highest_wave
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 4/Progress".text = "%d/5" % Stats.highest_wave
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 4/ProgressBar".value = 5
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 4/Progress".text = "5/5"
	if Stats.highest_wave >= 15:
		number5 = true
	if number5 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 5/ProgressBar".value = Stats.highest_wave
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 5/Progress".text = "%d/15" % Stats.highest_wave
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 5/ProgressBar".value = 15
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 5/Progress".text = "15/15"
	if Stats.highest_wave >= 30:
		number6 = true
	if number6 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 6/ProgressBar".value = Stats.highest_wave
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 6/Progress".text = "%d/30" % Stats.highest_wave
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 6/ProgressBar".value = 30
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 6/Progress".text = "30/30"
	if Stats.highest_wave >= 50:
		number7 = true
	if number7 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 7/ProgressBar".value = Stats.highest_wave
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 7/Progress".text = "%d/50" % Stats.highest_wave
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 7/ProgressBar".value = 50
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 7/Progress".text = "50/50"
	if Stats.enemies_defeated >= 1000:
		number8 = true
	if number8 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 8/ProgressBar".value = Stats.enemies_defeated
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 8/Progress".text = "%d/1000" % Stats.enemies_defeated
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 8/ProgressBar".value = 1000
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 8/Progress".text = "1000/1000"
	if Stats.attempts >= 50:
		number9 = true
	if number9 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 9/ProgressBar".value = Stats.attempts
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 9/Progress".text = "%d/50" % Stats.attempts
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 9/ProgressBar".value = 50
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 9/Progress".text = "50/50"
	if Stats.attempts >= 100:
		number10 = true
	if number10 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 10/ProgressBar".value = Stats.attempts
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 10/Progress".text = "%d/100" % Stats.attempts
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 10/ProgressBar".value = 100
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 10/Progress".text = "100/100"

	if Stats.enemies_defeated >= 2500:
		number11 = true
	if number11 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 11/ProgressBar".value = Stats.enemies_defeated
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 11/Progress".text = "%d/2500" % Stats.enemies_defeated
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 11/ProgressBar".value = 2500
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 11/Progress".text = "2500/2500"

	if Stats.enemies_defeated >= 5000:
		number12 = true
	if number12 == false:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 12/ProgressBar".value = Stats.enemies_defeated
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 12/Progress".text = "%d/5000" % Stats.enemies_defeated
	else:
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 12/ProgressBar".value = 5000
		$"ScrollContainer/MarginContainer/VBoxContainer/Achievement 12/Progress".text = "5000/5000"
