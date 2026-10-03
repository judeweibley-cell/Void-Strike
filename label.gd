extends Label

func _ready() -> void:
	while true:
		await get_tree().create_timer(0.5).timeout
		text = "Loading"
		await get_tree().create_timer(0.5).timeout
		text = "loading."
		await get_tree().create_timer(0.5).timeout
		text = "loading.."
		await get_tree().create_timer(0.5).timeout
		text = "loading..."
