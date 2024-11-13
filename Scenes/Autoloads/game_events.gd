extends Node

var game_time: float = 0.0

signal game_start
signal game_over

signal enemy_killed(type: int)
signal pickup_dropped(global_pos, type, value)
signal pickup_collected(type, value)

signal hand_update
signal deck_update
signal equipped(card: Card, instances: Array[Node2D])


func emit_game_start():
	game_start.emit()


func emit_game_over():
	game_over.emit()


func emit_enemy_killed(type: int):
	enemy_killed.emit(type)


func emit_pickup_dropped(global_pos: Vector2, type, value):
	pickup_dropped.emit(global_pos, type, value)


func emit_pickup_collected(type, value):
	pickup_collected.emit(type, value)
	

func emit_hand_update():
	hand_update.emit()


func emit_deck_update():
	deck_update.emit()


func emit_equipped(card: Card, instances: Array[Node2D]):
	equipped.emit(card, instances)
