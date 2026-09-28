extends Sprite2D

func _ready():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position", Vector2(200.0, 800), 4.0) 
	tween.tween_interval(0.002)
	tween.tween_property(self, "position", Vector2(320.0, 800), 4.0)
	tween.tween_interval(0.002) 
