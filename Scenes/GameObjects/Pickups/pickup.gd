extends Area2D
class_name Pickup

#VALUE CAN BE Card resource, String name of card, or index for preset items
#signal collected(type, val)

@export var pickup_type: Constants.PickupType
@export var card: Card
@export var card_name: String = ""
@export var value: float = 1.0


func emit_collected():
	if card != null:
		GameEvents.emit_pickup_collected(card, value)
		destroy()
		return
	if card_name.length() > 0:
		GameEvents.emit_pickup_collected(card_name, value)
		destroy()
		return
	GameEvents.emit_pickup_collected(pickup_type, value)
	
	destroy()
	

func destroy():
	queue_free()
