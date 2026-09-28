extends Control

@onready var settings_panel = $SettingsPanel
@onready var pb = $ParallaxBackground
@onready var leaderboard_panel = $NotesPanel

signal music_on
signal music_off

var scroll_speed = 100

func _process(delta):
	pb.scroll_offset.y += delta * scroll_speed

func _on_play_pressed():
	$ClickSound.play()
	await get_tree().create_timer(0.18).timeout
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_check_button_toggled(toggled_on: bool) -> void:
	release_focus()
	if toggled_on:
		BackgroundAudio._on_music_on()
	else:
		BackgroundAudio._on_music_off()

func _on_leaderboard_pressed() -> void:
	$ClickSound.play()
	if leaderboard_panel:
		leaderboard_panel.visible = not leaderboard_panel.visible
	else:
		leaderboard_panel.visible
	if settings_panel.visible:
		settings_panel.hide()

func _on_settings_pressed() -> void:
	$ClickSound.play()
	if settings_panel:
		settings_panel.visible = not settings_panel.visible
		if settings_panel.visible and leaderboard_panel:
			leaderboard_panel.hide()

func _ready():
	var my_name = "Player_One"
	$ClickSound.volume_db = -5.0

func _on_play_mouse_entered() -> void:
	$ClickSound.play()
