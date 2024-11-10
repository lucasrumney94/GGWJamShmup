extends Node

@export var main_game: PackedScene


func _ready():
	%StartButton.pressed.connect(on_start_pressed)


func on_start_pressed():
	get_tree().change_scene_to_packed(main_game)
