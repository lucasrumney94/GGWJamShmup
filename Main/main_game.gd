extends Node

@export var pause_screen: PackedScene


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		var ps = pause_screen.instantiate()
		add_child(ps)
		get_tree().paused = true


func _physics_process(delta):
	%Parallax2D.screen_offset.y += delta * 10
