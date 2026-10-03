extends Area2D

signal damage_player

@onready var base_scale: Vector2 = scale

func _ready() -> void:
	hide()
	monitoring = false 

func animate_explosion():
	print("ANIMATE EXPLOSION NOW")
	monitoring = true
	scale = base_scale * 0.8
	modulate.a = 1.0
	show()
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"): 
			damage_player.emit()
			monitoring = false
			break

	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	tween.tween_property(self, "scale", base_scale * 4, 0.3)
	tween.set_parallel(false)
	tween.tween_callback(hide)
	tween.tween_callback(func(): monitoring = false)

func _on_body_entered(body: Node2D) -> void:
	monitoring = true
	if body.has_method("take_damage"):
		body.take_damage()
		
		
		
		
