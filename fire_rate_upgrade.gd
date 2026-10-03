extends Button

signal buyfire

var cost = 5
var amount_purchased = 0
var coin = 0

func _ready():
	text = "Buy: " + str(cost)

func _on_pressed() -> void:
	if amount_purchased == 0:
		if coin >= cost:
			coin -= cost  
			amount_purchased += 1
			buyfire.emit(cost)
			cost = 10
			text = "Buy: " + str(cost)
			print("First upgrade purchased!")
	elif amount_purchased == 1:
		if coin >= cost:
			coin -= cost      
			amount_purchased += 1
			buyfire.emit(cost)
			cost = 20
			text = "Buy: " + str(cost)
			print("First upgrade purchased!")
	elif amount_purchased == 2:
		if coin >= cost:
			coin -= cost    
			amount_purchased += 1
			buyfire.emit(cost)
			cost = 35
			text = "Buy: " + str(cost)
			print("First upgrade purchased!")
	elif amount_purchased == 3:
		if coin >= cost:
			coin -= cost       
			amount_purchased += 1
			buyfire.emit(cost)
			cost = 55
			text = "Buy: " + str(cost)
			print("First upgrade purchased!")
	elif amount_purchased == 4:
		if coin >= cost:
			coin -= cost      
			amount_purchased += 1
			buyfire.emit(cost)
			text = "Sold Out"
			disabled = true      
			print("Second upgrade purchased!")
			
func _on_coins_send_coin_value(coins: Variant) -> void:
	coin = coins
