extends Node

signal closing


func _ready():
	%BackButton.pressed.connect(on_back_pressed)
	

func on_back_pressed():
	closing.emit()
	queue_free()
