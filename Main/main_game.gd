extends Node

@export var pause_screen: PackedScene

var game_running: bool = false
var game_time: float = 0.0


func _ready():
	GameEvents.game_over.connect(on_game_over)
	
	Callable(init).call_deferred()


func init():
	game_running = true
	GameEvents.emit_game_start()


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
