extends AudioStreamPlayer

func _ready():
	var root = get_tree().root
	if get_parent() != root:
		get_parent().remove_child(self)
		root.add_child(self)

	if not playing:
		play()
