extends Button

signal buy

var cost = 50
var amount_purchased = 0
var coin = 0

func _ready():
	text = "Buy: " + str(cost)

func _on_pressed() -> void:
	if amount_purchased == 0:
		if coin >= cost:
			coin -= cost 
			amount_purchased += 1
			buy.emit(cost)
			cost = 75
			text = "Buy: " + str(cost)
			print("First upgrade purchased!")

	elif amount_purchased == 1:
		if coin >= cost:
			coin -= cost         
			amount_purchased += 1
			buy.emit(cost)
			
			text = "Sold Out"
			disabled = true
			print("Second upgrade purchased!")

func _on_coins_send_coin_value(coins: Variant) -> void:
	coin = coins
