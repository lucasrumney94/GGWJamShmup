extends Node

signal closing

#@export var card_template: PackedScene


func _ready():
	#TODO populate with cards from CardManager
	populate_cards(true)
	populate_deck()
	%DeckList.item_selected.connect(on_deck_item_selected)
	
	%BackButton.pressed.connect(on_back_pressed)
	%BackButton.grab_focus()


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		on_back_pressed()


func populate_cards(show_all: bool):
	var card: Card = null
	for i in CardManager.cards.size():
		card = CardManager.cards[i]
		var ct = AssetsManager.card_template.instantiate()
		if CardManager.collected.has(card.id) || show_all:
			ct.setup_card(card, i)
			ct.selected.connect(on_card_selected)
		else:
			ct.setup_card(null, i)
		
		%CardsContainer.add_child(ct)


func populate_deck():
	for card in CardManager.deck_current_build:
		%DeckList.add_item(card.name)


func on_card_selected(index: int):
	#TODO try to add 1 of type to your hand
	#Need to display count
	print("SELECTING CARD " + str(index))


func on_deck_item_selected(index: int):
	#TODO remove item from deck and add back to collection
	print("SELECTING CARD IN DECK WITH INDEX " + str(index) 
	+ ". IT IS " + %DeckList.get_item_text(index))


func on_back_pressed():
	closing.emit()
	queue_free()
