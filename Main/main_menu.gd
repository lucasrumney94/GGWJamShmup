extends Node

@export var main_game: PackedScene

@export var card_collection: PackedScene
@export var options_menu: PackedScene
@export var upgrade_menu: PackedScene

@export var quit_scene: PackedScene

var submenu: Node


func _ready():
	%StartButton.pressed.connect(on_start_pressed)
	%DeckButton.pressed.connect(open_submenu.bind(card_collection, %DeckButton))
	%UpgradeButton.pressed.connect(open_submenu.bind(upgrade_menu, %UpgradeButton))
	%OptionsButton.pressed.connect(open_submenu.bind(options_menu, %OptionsButton))
	%QuitButton.pressed.connect(open_submenu.bind(quit_scene, %QuitButton))


func open_submenu(scene: PackedScene, button: Button = null):
	if submenu != null:
		submenu.queue_free()
	submenu = scene.instantiate()
	get_parent().add_child(submenu)
	if submenu.has_signal("closing"):
		submenu.closing.connect(focus_on_button.bind(button))


func focus_on_button(button: Button):
	if button == null:
		%StartButton.grab_focus()
		return
	
	button.grab_focus()


func on_start_pressed():
	get_tree().change_scene_to_packed(main_game)
