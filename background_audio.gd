extends AudioStreamPlayer2D

func _on_music_on() -> void:
	volume_db = 0.0
	
	if stream_paused:
		stream_paused = false
	elif not playing:
		play()

func _on_music_off() -> void:
	stream_paused = true
