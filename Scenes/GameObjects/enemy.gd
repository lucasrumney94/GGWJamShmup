extends CharacterBody2D

#signal enemy_died(type: int)

@export var enemy_type: Constants.EnemyType
@export var cards: Array[Card] = []
#@export var projectile: PackedScene


func _ready():
	$ShootTimer.timeout.connect(on_shoot_timeout)
	%HitBox.hit.connect(on_hit)


func Shoot():
	pass
	##instantiate projectile
	##set projectile velocity
	#var p = projectile.instantiate()
	#var parent = get_tree().get_first_node_in_group("projectile_layer")
	#if parent == null:
		#parent = get_parent()
		#
	#p.global_position = global_position
	#parent.add_child(p)
	#p.velocity = Vector2.DOWN * 100


func on_shoot_timeout():
	Shoot()
	

func on_hit(strength: float):
	destroy()


func destroy():
	GameEvents.emit_enemy_killed(enemy_type)
	for card in cards:
		GameEvents.emit_pickup_dropped(global_position, card, 1)
	queue_free()
