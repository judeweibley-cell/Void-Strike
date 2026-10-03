extends Area2D

func _ready():
	hide()

func animate_explosion():
	scale = Vector2(1, 1)
	modulate.a = 1.0
	show()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.8, 1.8), 0.3)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.chain().tween_callback(hide)

func _on_suicider_animate_explosion() -> void:
	animate_explosion()

func _on_shooting_enemy_1_animate_explosion() -> void:
	animate_explosion()
