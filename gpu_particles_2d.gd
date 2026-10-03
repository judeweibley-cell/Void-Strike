extends GPUParticles2D

func _physics_process(delta: float) -> void:
	var velocity: Vector2 = get_parent().velocity
	if velocity == Vector2.ZERO:
		emitting = false
		return
	emitting = true
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			_set_movement_style("right")
		else:
			_set_movement_style("left")
	else:
		if velocity.y > 0:
			_set_movement_style("backward")
		else:
			_set_movement_style("forward")

func _set_movement_style(direction: String) -> void:
	match direction:
		"forward":
			amount = 7
			lifetime = 0.3
		"backward":
			amount = 2
			lifetime = 0.15
		"left":
			amount = 5
			lifetime = 0.2
		"right":
			amount = 5
			lifetime = 0.2
