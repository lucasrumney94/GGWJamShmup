extends Area2D

var velocity: Vector2 = Vector2.ZERO


func _ready():
	body_entered.connect(on_body_entered)


func _physics_process(delta):
	global_position += velocity * delta
	#var collision = move_and_collide(velocity * delta)
	#if collision:
		#var motion = collision.get_remainder().bounce(collision.get_normal())
		#velocity = velocity.bounce(collision.get_normal())
		#move_and_collide(motion)
		#if collision_mask & 2 == 2:
			#use_friendly_collision()
			#collision_mask = collision_mask & ~2
			#collision_mask = collision_mask | 4
	#pass
	
func on_body_entered(body: Node2D):
	velocity = velocity.bounce((global_position - body.global_position).normalized())
	if collision_mask & 2 == 2:
		use_friendly_collision()


func use_friendly_collision():
	collision_mask = collision_mask & ~2
	collision_mask = collision_mask | 4
	
	collision_layer = collision_layer & ~8
	collision_layer = collision_layer | 16
