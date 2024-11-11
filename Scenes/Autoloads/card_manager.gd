extends Node

@export var card_select_ui: PackedScene
#FILL THIS WITH POSSIBLE CARDS
@export var cards: Array[Card] = []

var collection: Dictionary = {}
@export var deck_current_build: Array[Card] = []

#ARRAYS FOR CURRENT GAME
var deck: Array[Card] = []
var hand: Array[Card] = []
var equipped: Array[Card] = []




func _ready():
	#TODO load collection and current deck from save file
	Callable(init).call_deferred()


func init():
	#TODO load collection and current deck from save file
	GameEvents.game_start.connect(on_game_start)


func add_card(card: Card, to_deck: bool):
	#TODO add card to collection
	pass


func remove_card(card: Card):
	#TODO remove one of these from the collection
	pass
	

func offer_hand():
	if hand.size() <= 0:
		printerr("NO HAND TO OFFER")
	
	#pause the game and show the current hand for selection
	#TODO WE'LL EASE INTO THIS, I'M JUST TRYING TO GET IT WORKING!
	get_tree().paused = true
	var selection_screen = card_select_ui.instantiate()
	add_child(selection_screen)
	selection_screen.populate_selection(hand)
	selection_screen.closing.connect(play_card)


func on_game_start():
	deck = deck_current_build.duplicate()
	deck.shuffle()
	for i in 3:
		deal_card()
	
	offer_hand()


func deal_card():
	if deck.size() <= 0:
		return
			
	var card = deck[0]
	hand.append(card)
	deck.remove_at(0)


func play_card(hand_index: int):
	if hand_index < 0 || hand_index >= hand.size():
		printerr("HAND INDEX OUT OF RANGE")
		return
	
	var card = hand[hand_index]
	hand.remove_at(hand_index)
	
	match card.type:
		Constants.CardType.GUN, Constants.CardType.ACTIVE, Constants.CardType.PASSIVE:
			var players = get_tree().get_nodes_in_group("player")
			for player in players:
				if !player.input_component.is_player:
					continue
				player.add_armament(card.scene)#get to player.add_armament(card.scene)
			equipped.append(card)
		Constants.CardType.BOMB:
			#FIRE OFF BOMB, INSERT BACK INTO DECK
			pass
		Constants.CardType.EFFECT:
			pass
	
	
	get_tree().paused = false
	
