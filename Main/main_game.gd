extends Node

@export var pause_screen: PackedScene

var game_running: bool = false
var game_time: float = 0.0


func _ready():
	GameEvents.game_over.connect(on_game_over)
	
	GameEvents.deck_update.connect(update_deck_container)
	GameEvents.hand_update.connect(update_hand_container)
	update_deck_container()
	update_hand_container()
	#TODO update equipped container
	
	Callable(init).call_deferred()


func init():
	game_running = true
	GameEvents.emit_game_start()


func update_deck_container():
	var current_children = %DeckContainer.get_children()
	if current_children.size() < CardManager.deck.size():
		for i in (CardManager.deck.size() - current_children.size()):
			var ct = AssetsManager.card_template.instantiate()
			%DeckContainer.add_child(ct)
	elif current_children.size() > CardManager.deck.size():
		for i in current_children.size():
			var index = current_children.size() - 1 - i
			if index >= CardManager.deck.size():
				current_children[index].queue_free()


func update_hand_container():
	for child in %HandContainer.get_children():
		child.queue_free()
		#TODO maybe do this differently, allow shifting cards around
		
	for i in CardManager.hand.size():
		var card = AssetsManager.card_template.instantiate()
		%HandContainer.add_child(card)
		card.setup_card(CardManager.hand[i], i)


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var ps = pause_screen.instantiate()
		add_child(ps)
		get_tree().paused = true


func _process(delta):
	#%Parallax2D.screen_offset.y += delta * 10
	
	if game_running:
		game_time += delta
		GameEvents.game_time = game_time
		%TimeLabel.text = Utilities.float_to_time_string(game_time)


func on_game_over():
	game_running = false
