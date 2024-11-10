extends Node

#FILL THIS WITH POSSIBLE CARDS
@export var cards: Array[Card] = []

var collection: Dictionary = {}
var deck: Array[Card]


func _ready():
	#TODO load collection and current deck from save file
	pass


func add_card(card: Card, to_deck: bool):
	#TODO add card to collection
	pass


func remove_card(card: Card):
	#TODO remove one of these from the collection
	pass
