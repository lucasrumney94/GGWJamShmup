extends Area2D

signal hit(strength: float)

func _ready():
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D):
	hit.emit(1.0)
