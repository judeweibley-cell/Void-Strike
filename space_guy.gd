extends Sprite2D

@export var float_amplitude: float = 20.0
@export var float_speed: float = 0.5

var time_passed: float = 0.0
var start_y: float = 0.0

func _ready() -> void:
	start_y = position.y

func _process(delta: float) -> void:
	time_passed += delta * float_speed
	position.y = start_y + sin(time_passed) * float_amplitude
