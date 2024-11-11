extends CanvasLayer

signal closing(selection: int)


func _input(event: InputEvent):
	#THIS IS JUST TO GET IT WORKING> CLICKING CARDS NOT WORKING YET
	if event.is_action_pressed("ui_accept"):
		on_card_selected(0)
	


func populate_selection(hand: Array[Card]):
	if hand == null:
		printerr("there's no hand to select from")
		destroy()
		return
	if hand.is_empty():
		printerr("hand is empty")
		destroy()
		return
	
	for i in hand.size():
		var card = AssetsManager.card_template.instantiate()
		%CardContainer.add_child(card)
		card.setup_card(hand[i], i)
		
		card.selected.connect(on_card_selected.bind(i))


func destroy():
	get_tree().paused = false
	queue_free()


func on_card_selected(hand_index: int):
	closing.emit(hand_index)
	queue_free()
