extends Area2D
class_name Laser

var suicider_block

@export var speed = 600
@export var damage = 1

func _physics_process(_delta):
	global_position.y += -speed * _delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area):
	print("hit target")
	
	if area.has_method("damage"):
		queue_free()
		area.damage(1)
		queue_free()
		return 
	elif area.has_method("take_damage"):
		area.take_damage(1)
		queue_free()
		return

	var target_parent = area.get_parent()
	if target_parent:
		if target_parent.has_method("damage"):
			target_parent.damage(1)
			if suicider_block == false:
				queue_free()
			return
		elif target_parent.has_method("take_damage"):
			target_parent.take_damage(1)
			queue_free()
			return

func laser():
	pass
