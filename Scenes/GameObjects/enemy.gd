extends CharacterBody2D

@export var projectile: PackedScene


func _ready():
	$ShootTimer.timeout.connect(on_shoot_timeout)


func Shoot():
	#instantiate projectile
	#set projectile velocity
	var p = projectile.instantiate()
	get_parent().add_child(p)
	p.global_position = global_position
	p.velocity = Vector2.DOWN * 100


func on_shoot_timeout():
	Shoot()
