extends Node2D


func _ready():
	GameEvents.pickup_dropped.connect(on_pickup_dropped)


func on_pickup_dropped(global_pos: Vector2, type, value):
	Callable(drop_pickup.bind(global_pos, type, value)).call_deferred()


func drop_pickup(global_pos: Vector2, type, value):
	var pickup = AssetsManager.pickup.instantiate()
	if type is String:
		pickup.card_name = type
		type = CardManager.get_card_from_string(type)
	if type is Card:
		pickup.card = type
		pickup.global_position = global_pos
		
	if type is int:
		pickup.pickup_type = type as Constants.PickupType
	
	add_child(pickup)
	
	
