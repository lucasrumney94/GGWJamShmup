extends Area2D


func _ready():
	body_entered.connect(on_body_entered)
	area_entered.connect(on_area_entered)


func on_body_entered(body: Node2D):
	body.queue_free()


func on_area_entered(area: Area2D):
	area.queue_free()
