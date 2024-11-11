extends Control

signal selected

var card: Card
var selection_index: int = -1


func _ready():
	mouse_entered.connect(on_mouse_entered)
	gui_input.connect(on_gui_input)
	


func setup_card(new_card: Card, index: int):
	selection_index = index
	card = new_card
	%NameLabel.text = card.name
	%DescriptionLabel.text = card.details
	%ArtworkTextureRect.texture = card.texture


func on_mouse_entered():
	#TODO send signal to display data for this card
	#TODO HIGHLIGHT
	print("MOUSE CURSOR HAS ENTERED CARD")
	pass


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit(selection_index)
	
