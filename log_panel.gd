extends Panel

signal send_time(hours: int, minutes: int)
signal send_wave(highest_wave)

@onready var target_panel = $"."
@onready var Attempts = $Stats/Attempts
@onready var Enemies_Defeated = $"Stats/Enemies Defeated"
@onready var time_label = $"Stats/Time Played"
@onready var coin_label = $"Stats/Coins Collected"

func _process(_delta: float) -> void:
	var total_seconds = int(Stats.playtime)
	var hours = total_seconds / 3600
	var minutes = (total_seconds % 3600) / 60
	var seconds = total_seconds % 60
	
	$"Stats/Power Ups".text = "Power-ups Collected: " + str(Stats.power_ups_collected)
	
	$"Stats/Fuel Burned".text = "Total Fuel Burned: " + str(int(Stats.fuel_burned))
	
	$"Stats/Highest Wave".text = "Highest Wave: " + str(Stats.highest_wave)
	
	$"Stats/Upgrade Bought".text = "Upgrades Bought: " + str(Stats.upgrades_bought)
	
	$"Stats/Time Played".text = "Playtime: %02d:%02d:%02d" % [hours, minutes, seconds]
	send_time.emit(hours, minutes)

func _ready() -> void:
	
	Stats.coins_changed.connect(_on_coins_changed)
	_on_coins_changed()
	
	Stats.shoot_bullet.connect(_on_bullet_shot_received)
	$"Stats/Bullets Fired".text = "Bullets Fired: " + str(Stats.bullets_fired)
	
	$Stats/Attempts.text = "Attempts: " + str(Stats.attempts)
	$"Stats/Enemies Defeated".text = "Enemies Defeated: " + str(Stats.enemies_defeated)
	
	target_panel.hide()
	
	Stats.enemy_killed.connect(_on_enemy_killed_received)

func _on_exit_pressed() -> void:
	release_focus()
	target_panel.hide()

func _on_log_pressed() -> void:
	Enemies()
	release_focus()
	target_panel.show()

func _on_log_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_exit_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_enemy_killed_received() -> void:
	print("UPDATE STATS NEW ENEMY KILLED")
	$"Stats/Enemies Defeated".text = "Enemies Defeated: " + str(Stats.enemies_defeated)

func _on_play_pressed() -> void:
	Stats.attempts += 1 
	$Stats/Attempts.text = "Attempts: " + str(Stats.attempts)
	Stats.save_game()

func _on_bullet_shot_received() -> void:
	print("The player shot a bullet!")
	$"Stats/Bullets Fired".text = "Bullets Fired: " + str(Stats.bullets_fired)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Stats.save_game() 

func _on_coins_changed() -> void:
	coin_label.text = "Coins Collected: " + str(Stats.coins)

func Statistics():
	$Stats.show()
	$Achievements.hide()
	$Enemies.hide()
	$Label.text = "Statistics"

func Achievements():
	$Achievements/ScrollContainer.scroll_vertical = 0
	$Achievements.show()
	$Stats.hide()
	$Enemies.hide()
	$Label.text = "Achievements"

func Enemies():
	$Enemies/ScrollContainer.scroll_vertical = 000
	$Enemies.show()
	$Achievements.hide()
	$Stats.hide()
	$Label.text = "Enemies"

func _on_enemies_button_pressed() -> void:
	Enemies()
	release_focus()

func _on_achievements_button_pressed() -> void:
	Achievements()
	release_focus()

func _on_statistics_button_pressed() -> void:
	Statistics()
	release_focus()

func _on_enemies_button_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_achievements_button_mouse_entered() -> void:
	$"../ClickSound".play()

func _on_statistics_button_mouse_entered() -> void:
	$"../ClickSound".play()
