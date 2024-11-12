extends Area2D

signal hit(strength: float)

func _ready():
	body_entered.connect(on_body_entered)
	area_entered.connect(on_area_entered)


func on_body_entered(body: Node2D):
	hit.emit(1.0)


func on_area_entered(area: Area2D):
	hit.emit(1.0)
