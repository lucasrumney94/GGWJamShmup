extends Control

func _ready():
	GameEvents.equipped.connect(on_equipped)


func on_equipped(card: Card, instances: Array[Node2D]):
	var ct = AssetsManager.card_template.instantiate()
	ct.setup_card(card, -1)
	#TODO need to cache instances somewhere
	add_child(ct)
	
	reposition_cards()


func reposition_cards():
	pass
