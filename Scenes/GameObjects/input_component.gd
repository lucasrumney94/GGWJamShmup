extends Node
class_name InputComponent

@export var is_player: bool = true

#TODO okay the idea with this is to be able to accept a string of commands
#These commands will have a game-relative time stamp
#and what input changed at that time
#when caching ghost runs, get initial position and velocity
#	followed by the input changes over time
#		this should be the most succinct way to manage recording

var move_vector: Vector2 = Vector2.ZERO
var attack: bool = false
var active: bool = false


func get_attacking() -> bool:
	if is_player:
		attack = Input.is_action_pressed("attack")
		
	return attack


func get_active() -> bool:
	if is_player:
		active = Input.is_action_pressed("active")
	
	return active


func get_move_vector() -> Vector2:
	if is_player:
		move_vector = Input.get_vector("left", "right", "forward", "backward")
	
	return move_vector
