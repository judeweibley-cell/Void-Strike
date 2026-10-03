extends Label

func _ready() -> void:
	text = "~~Highscore: " + str(Stats.highscore) + "~~"
	pivot_offset = size / 2
	var tween = create_tween().set_loops()
	tween.tween_property(self, "rotation_degrees", 1, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation_degrees", -1, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
