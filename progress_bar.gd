extends ProgressBar

var increase_speed: float = 20.0

func _ready():
	value = 0.0

func _process(delta: float):
	if value < max_value:
		value += increase_speed * delta

	if value >= max_value:
		$"..".hide()
