extends Node2D

var number

signal spawn

@onready var coin_scene = preload("res://scenes/Coin.tscn")

func _on_shooting_enemy_2_killed() -> void:
	pass

func _on_enemy_coin(pos: Variant) -> void:
	number = randi_range(1, 5)
	
	if number == 1:
		var new_coin = coin_scene.instantiate()
		new_coin.global_position = pos
		new_coin.collect.connect($"/root/Game/Coins"._on_coin_collect)
		get_parent().add_child(new_coin)
		spawn.emit()

func _on_shooting_enemy_1_coin(pos: Variant) -> void:
	number = randi_range(1, 4)
	
	if number == 1:
		var new_coin = preload("res://scenes/Coin.tscn").instantiate()
		new_coin.global_position = pos
		new_coin.collect.connect($"/root/Game/Coins"._on_coin_collect)
		get_parent().add_child(new_coin)
		spawn.emit()


func _on_shooting_enemy_2_coin(pos: Variant) -> void:
	number = randi_range(1, 4)
	
	if number == 1:
		var new_coin = preload("res://scenes/Coin.tscn").instantiate()
		new_coin.global_position = pos
		new_coin.collect.connect($"/root/Game/Coins"._on_coin_collect)
		get_parent().add_child(new_coin)
		spawn.emit()

func _on_tank_enemy_coin(pos: Variant) -> void:
	print("hi")
	number = randi_range(1, 4)
	print(number)
	if number == 1:
		var new_coin = preload("res://scenes/Coin.tscn").instantiate()
		new_coin.global_position = pos
		new_coin.collect.connect($"/root/Game/Coins"._on_coin_collect)
		get_parent().add_child(new_coin)
		spawn.emit()

func _on_suicider_coin(pos: Variant) -> void:
	number = randi_range(1, 4)
	print(number)
	if number == 1:
		var new_coin = preload("res://scenes/Coin.tscn").instantiate()
		new_coin.global_position = pos
		new_coin.collect.connect($"/root/Game/Coins"._on_coin_collect)
		get_parent().add_child(new_coin)
		spawn.emit()
