extends Node

signal closing


func _ready():
	%CancelButton.pressed.connect(on_back_pressed)
	%ConfirmButton.pressed.connect(on_confirm_pressed)
	

func on_confirm_pressed():
	get_tree().quit()


func on_back_pressed():
	closing.emit()
	queue_free()
