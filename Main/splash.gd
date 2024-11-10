extends Node

@export var next_scene: PackedScene
@export var display_time: float = 2.0


func _ready():
	$Timer.wait_time = display_time
	$Timer.timeout.connect(on_timer_timeout)
	$Timer.start()


func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel") || event.is_action_pressed("left_click"):
		on_timer_timeout()


func on_timer_timeout():
	get_tree().change_scene_to_packed(next_scene)
