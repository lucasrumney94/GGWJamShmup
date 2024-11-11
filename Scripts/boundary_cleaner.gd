extends Area2D


func _ready():
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D):
	body.queue_free()
