extends Node

#@export var main_menu: PackedScene
@export var options_menu: PackedScene


func _ready():
	%ResumeButton.pressed.connect(on_resume_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


func on_resume_pressed():
	get_tree().paused = false
	queue_free()


func on_options_pressed():
	var options = options_menu.instantiate()
	get_parent().add_child(options)


func on_quit_pressed():
	get_tree().paused = false
	Engine.time_scale = 1.0
	#get_tree().change_scene_to_packed(main_menu)
	get_tree().change_scene_to_file("res://Main/main_menu.tscn")
