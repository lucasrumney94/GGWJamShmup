extends Area2D


func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D):
	print(area.name + " HAS ENTERED PLAYER PICKUP AREA")
	#if area is Pickup:
	if area.has_method("emit_collected"):
		area.emit_collected()
