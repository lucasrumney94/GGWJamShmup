extends Node

var game_time: float = 0.0

signal game_over


func emit_game_over():
	game_over.emit()
