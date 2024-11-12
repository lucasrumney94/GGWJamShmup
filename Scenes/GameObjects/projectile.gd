extends CharacterBody2D


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var motion = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(motion)
		if collision_mask & 2 == 2:
			use_friendly_collision()
			#collision_mask = collision_mask & ~2
			#collision_mask = collision_mask | 4
	#pass

func use_friendly_collision():
	collision_mask = collision_mask & ~2
	collision_mask = collision_mask | 4
	
	collision_layer = collision_layer & ~8
	collision_layer = collision_layer | 16
